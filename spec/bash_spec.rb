# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: bash
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

describe 'elite::bash' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_bash elite_dotlink),
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['bash'] = true
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'creates elite_bash[sliim]' do
    expect(subject).to create_elite_bash('sliim')
  end

  it 'does not create elite_bash[foo]' do
    expect(subject).to_not create_elite_bash('foo')
  end

  it 'creates cookbook_file[/home/sliim/.dotfiles/bashrc]' do
    expect(subject).to create_cookbook_file('/home/sliim/.dotfiles/bashrc')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            cookbook: 'elite',
            source: 'bashrc')
  end

  it 'creates elite_dotlink[sliim-bashrc]' do
    expect(subject).to create_elite_dotlink('sliim-bashrc')
      .with(owner: 'sliim',
            file: 'bashrc')
  end

  it 'creates link[/home/sliim/.bashrc]' do
    expect(subject).to create_link('/home/sliim/.bashrc')
      .with(owner: 'sliim',
            group: 'elite',
            link_type: :symbolic,
            to: '/home/sliim/.dotfiles/bashrc')
  end
end
