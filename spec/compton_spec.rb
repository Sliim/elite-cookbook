# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: compton
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

describe 'elite::compton' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_compton)) do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['compton']['config'] = {
        'opacity-rule' => '["80:class_g = \'URxvt\'"];',
      }
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'installs package[compton]' do
    expect(subject).to install_package('compton')
  end

  it 'creates elite_compton[sliim]' do
    expect(subject).to create_elite_compton('sliim')
  end

  it 'does not create elite_compton[foo]' do
    expect(subject).to_not create_elite_compton('foo')
  end

  it 'creates elite_elite_configd[sliim]' do
    expect(subject).to create_elite_configd('sliim')
  end

  it 'creates template[/home/sliim/.dotfiles/config/compton.conf]' do
    config_file = '/home/sliim/.dotfiles/config/compton.conf'
    matches = [start_with('# Generated by Chef!'),
               /^opacity-rule = \["80:class_g = 'URxvt'"\];$/]

    expect(subject).to create_template(config_file)
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'ini.erb',
            cookbook: 'elite')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end
end
