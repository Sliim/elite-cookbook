# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: dunst
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

describe 'elite::dunst' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_dunst elite_configd elite_sound),
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['dunst'] = {}
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'includes recipe[dunst]' do
    expect(subject).to include_recipe('dunst')
  end

  it 'creates elite_dunst[sliim]' do
    expect(subject).to create_elite_dunst('sliim')
  end

  it 'creates elite_configd[sliim]' do
    expect(subject).to create_elite_configd('sliim')
  end

  it 'creates directory[/home/sliim/.dotfiles/config]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/config')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates elite_dotlink[sliim-configd]' do
    expect(subject).to create_elite_dotlink('sliim-configd')
      .with(owner: 'sliim',
            file: 'config')
  end

  it 'creates directory[/home/sliim/.dotfiles/config/dunst]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/config/dunst')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates template[/home/sliim/.dotfiles/config/dunstrc]' do
    expect(subject).to create_template('/home/sliim/.dotfiles/config/dunst/dunstrc')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'dunstrc.erb',
            cookbook: 'dunst')
  end

  it 'creates elite_bin[sliim-notifier]' do
    expect(subject).to create_elite_bin('sliim-notifier')
      .with(owner: 'sliim',
            script: 'notifier',
            cookbook: 'elite',
            source_dir: 'bin/')
  end

  it 'creates directory[/home/sliim/.dotfiles/sounds]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/sounds')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates elite_dotlink[sliim-sounds]' do
    expect(subject).to create_elite_dotlink('sliim-sounds')
      .with(owner: 'sliim',
            file: 'sounds')
  end

  ['bip.wav', 'alert.wav'].each do |s|
    it "creates elite_sound[sliim-#{s}]" do
      expect(subject).to create_elite_sound("sliim-#{s}")
        .with(owner: 'sliim',
              sound: s,
              cookbook: 'elite',
              source_dir: 'sounds/')
    end

    it "creates cookbook_file[/home/sliim/.dotfiles/sounds/#{s}]" do
      expect(subject).to create_cookbook_file("/home/sliim/.dotfiles/sounds/#{s}")
        .with(owner: 'sliim',
              group: 'elite',
              mode: '0640',
              source: "sounds/#{s}",
              cookbook: 'elite')
    end
  end
end
