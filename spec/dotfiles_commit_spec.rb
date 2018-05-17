# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: dotfiles_commit
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

require 'chefspec'
require 'chefspec/berkshelf'

describe 'elite::dotfiles_commit' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['users'] = %w(sliim)
      node.override['elite']['sliim'] = {
        'init_repo' => true,
        'dotfd' => '/home/sliim/.stuff',
        'email' => 'sliim@spec',
        'shell' => '/bin/bash',
        'group' => 'elite',
        'groups' => %w(elite),
        'password' => nil,
      }
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'runs execute[dpkg -l > packages.txt]' do
    expect(subject).to run_execute('dpkg -l > packages.txt')
      .with(cwd: '/home/sliim/.stuff',
            user: 'sliim',
            group: 'elite')
  end

  it 'runs execute[git add -A]' do
    expect(subject).to run_execute('git add -A')
      .with(cwd: '/home/sliim/.stuff',
            user: 'sliim',
            group: 'elite')
  end

  it 'runs execute[git commit -m "Chef provisionning" --allow-empty]' do
    expect(subject).to run_execute('git commit -m "Chef provisionning" --allow-empty')
      .with(cwd: '/home/sliim/.stuff',
            user: 'sliim',
            group: 'elite')
  end
end
