# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: terminfo
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

describe 'elite::terminfo' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_terminfo),
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['terminfo']['cookbook'] = 'elite'
      node.override['elite']['sliim']['terminfo']['source_dir'] = 'terminfo'
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_terminfo[sliim]' do
    expect(subject).to create_elite_terminfo('sliim')
      .with(cookbook: 'elite',
            source_dir: 'terminfo',
            user: 'sliim')
  end

  it 'does not create elite_terminfo[foo]' do
    expect(subject).to_not create_elite_terminfo('foo')
  end

  it 'creates remote_directory[/home/sliim/.dotfiles/terminfo]' do
    expect(subject).to create_remote_directory('/home/sliim/.dotfiles/terminfo')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            files_owner: 'sliim',
            files_group: 'elite',
            files_mode: '0640',
            source: 'terminfo')
  end

  it 'creates elite_dotlink[sliim-terminfo]' do
    expect(subject).to create_elite_dotlink('sliim-terminfo')
      .with(owner: 'sliim',
            file: 'terminfo')
  end
end
