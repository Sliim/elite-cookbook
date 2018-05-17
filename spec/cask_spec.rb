# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: cask
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

describe 'elite::cask' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['elite_cask']) do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['cask']['repository'] = 'https://remote/cask.git'
      node.override['elite']['sliim']['cask']['reference'] = 'mybranch'
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_cask[sliim]' do
    expect(subject).to create_elite_cask('sliim')
      .with(repository: 'https://remote/cask.git',
            reference: 'mybranch')
  end

  it 'syncs git[/home/sliim/.cask]' do
    expect(subject).to sync_git('/home/sliim/.cask')
      .with(user: 'sliim',
            group: 'elite',
            repository: 'https://remote/cask.git',
            reference: 'mybranch')
  end
end
