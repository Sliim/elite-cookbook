# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: bin
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

describe 'elite::bin' do
  let(:subject) do
    ChefSpec::SoloRunner
      .new(step_into: ['elite_bin'],
           platform: 'debian',
           version: '9.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['bin']['wrapper']['scripts'] = %w(foo bar)
      node.override['elite']['sliim']['bin']['wrapper']['source_dir'] = 'mybin/'
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_bin[sliim-foo]' do
    expect(subject).to create_elite_bin('sliim-foo')
      .with(owner: 'sliim',
            script: 'foo',
            cookbook: 'wrapper',
            source_dir: 'mybin/')
  end

  it 'creates elite_bin[sliim-bar]' do
    expect(subject).to create_elite_bin('sliim-bar')
      .with(owner: 'sliim',
            script: 'bar',
            cookbook: 'wrapper',
            source_dir: 'mybin/')
  end

  it 'creates directory[/home/sliim/.dotfiles/bin]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/bin')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates elite_dotlink[sliim-bin]' do
    expect(subject).to create_elite_dotlink('sliim-bin')
      .with(dotprefix: false,
            owner: 'sliim',
            file: 'bin')
  end

  it 'creates cookbook_file[/home/sliim/.dotfiles/bin/foo]' do
    expect(subject).to create_cookbook_file('/home/sliim/.dotfiles/bin/foo')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            source: 'mybin/foo',
            cookbook: 'wrapper')
  end

  it 'creates cookbook_file[/home/sliim/.dotfiles/bin/bar]' do
    expect(subject).to create_cookbook_file('/home/sliim/.dotfiles/bin/bar')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            source: 'mybin/bar',
            cookbook: 'wrapper')
  end
end
