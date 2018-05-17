# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: irssi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative 'spec_helper'

describe 'elite::irssi' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['elite_irssi']) do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['irssi']['cookbook'] = 'elite'
      node.override['elite']['sliim']['irssi']['startup'] = ['/bind meta-> previous_window', '/bind meta-< next_window']
      node.override['elite']['sliim']['irssi']['servers'] = [{ address: 'irc.hackint.eu', chatnet: 'ccc', port: '9999', use_ssl: 'yes', ssl_verify: 'no', autoconnect: 'yes' }]
      node.override['elite']['sliim']['irssi']['channels'] = [{ name: '#hackbbs', chatnet: 'ccc', autojoin: 'yes' }]
      node.override['elite']['sliim']['irssi']['chatnets'] = %w(ccc 2600)
      node.override['elite']['sliim']['irssi']['aliases'] = { j: 'join', q: 'quit' }
      node.override['elite']['sliim']['irssi']['settings'] = { core: { real_name: 'Sliim', user_name: 'Sliim', nick: 'Sliim' } }
      node.override['elite']['sliim']['irssi']['hilights'] = [{ text: 'Sliim', nick: 'yes', word: 'yes' },
                                                              { text: 'S', nick: 'yes', word: 'no' }]
    end.converge(described_recipe)
  end

  it 'installs package[irssi]' do
    expect(subject).to install_package('irssi')
  end

  it 'creates directory[/home/sliim/.dotfiles/irssi]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/irssi')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates remote_directory[/home/sliim/.dotfiles/irssi/scripts]' do
    expect(subject).to create_remote_directory('/home/sliim/.dotfiles/irssi/scripts')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            files_owner: 'sliim',
            files_group: 'elite',
            files_mode: '0640',
            source: 'irssi/scripts')
  end

  it 'creates file[/home/sliim/.dotfiles/irssi/startup]' do
    config_file = '/home/sliim/.dotfiles/irssi/startup'
    matches = [%r{^\/bind meta-> previous_window$},
               %r{^\/bind meta-< next_window$}]

    expect(subject).to create_file(config_file)
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end

  it 'creates template[/home/sliim/.dotfiles/irssi/config]' do
    config_file = '/home/sliim/.dotfiles/irssi/config'
    matches = [start_with('# Generated by Chef!'),
               /servers = \(\n\s+\{\n\s+address = "irc.hackint.eu";\n\s+chatnet = "ccc";\n\s+port = "9999";\n\s+use_ssl = "yes";\n\s+ssl_verify = "no";\n\s+autoconnect = "yes";\n\s+\}\n\);/,
               /channels = \(\n\s+\{\n\s+name = "#hackbbs";\n\s+chatnet = "ccc";\n\s+autojoin = "yes";\n\s+\}\n\);/,
               /chatnets = \{\n\s+ccc = \{ type = "IRC"; \};\n\s+2600 = \{ type = "IRC"; \};\n\};/,
               /aliases = \{\n\s+j = "join";\n\s+q = "quit";\n\};/,
               /settings = \{\n\s+core = \{\n\s+real_name = "Sliim";\n\s+user_name = "Sliim";\n\s+nick = "Sliim";\n\s+\};\n\};/,
               /hilights = \(\n\s+\{\n\s+text = "Sliim";\n\s+nick = "yes";\n\s+word = "yes";\n\s+\},\n\s+\{\n\s+text = "S";\n\s+nick = "yes";\n\s+word = "no";\n\s+\}\n\);/,
              ]

    expect(subject).to create_template(config_file)
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'irssi/config.erb',
            cookbook: 'elite')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end

  it 'creates elite_dotlink[sliim-irssi]' do
    expect(subject).to create_elite_dotlink('sliim-irssi')
      .with(owner: 'sliim',
            file: 'irssi')
  end
end
