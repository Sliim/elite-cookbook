# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: conky
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

describe 'elite::conky' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_conky),
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['conky'] = {}
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_conky[sliim]' do
    expect(subject).to create_elite_conky('sliim')
  end

  it 'does not create elite_conky[foo]' do
    expect(subject).to_not create_elite_conky('foo')
  end

  it 'installs package[conky]' do
    expect(subject).to install_package('conky')
  end

  it 'creates directory[/home/sliim/.dotfiles/conky.d]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/conky.d')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates elite_dotlink[sliim-conky]' do
    expect(subject).to create_elite_dotlink('sliim-conky')
      .with(owner: 'sliim',
            file: 'conky.d')
  end

  it 'creates directory[/home/sliim/.dotfiles/conky.d/var]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/conky.d/var')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates directory[/home/sliim/.dotfiles/conky.d/scripts]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/conky.d/scripts')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end
end
