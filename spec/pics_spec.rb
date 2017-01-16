# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: ack
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

describe 'elite::pics' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_picture elite_pics elite_dotlink),
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['pics'] = ['img1.jpg']
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'creates directory[/home/sliim/.dotfiles/pics/scrot]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/pics/scrot')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            recursive: true)
  end

  it 'creates elite_picture[img1.jpg]' do
    expect(subject).to create_elite_picture('img1.jpg')
  end

  it 'creates elite_dotlink[pics]' do
    expect(subject).to create_elite_dotlink('pics').with(dotprefix: false,
                                                         skip_if_exists: true)
  end

  it 'creates directory[/home/sliim/.dotfiles/pics]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/pics')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates cookbook_file[/home/sliim/.dotfiles/pics/img1.jpg]' do
    expect(subject).to create_cookbook_file('/home/sliim/.dotfiles/pics/img1.jpg')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'pics/img1.jpg')
  end

  context 'without dot prefix' do
    before do
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with('/home/sliim/pics').and_return false
    end

    it 'creates link[/home/sliim/pics]' do
      expect(subject).to create_link('/home/sliim/pics')
        .with(owner: 'sliim',
              group: 'elite',
              link_type: :symbolic,
              to: '/home/sliim/.dotfiles/pics')
    end
  end

  context 'with skip_if_exists' do
    before do
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with('/home/sliim/pics').and_return true
    end

    it 'does not create link[/home/sliim/pics]' do
      expect(subject).to_not create_link('/home/sliim/pics')
    end
  end
end
