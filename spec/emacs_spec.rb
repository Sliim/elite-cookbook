# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: emacs
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

describe 'elite::emacs' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_emacs elite_desktop_app),
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['name'] = 'Sliim'
      node.override['elite']['sliim']['email'] = 'sliim@mailoo.org'
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['emacs']['repository'] = 'https://remote/emacs.d.git'
      node.override['elite']['sliim']['emacs']['reference'] = 'mybranch'
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_emacs[sliim]' do
    expect(subject).to create_elite_emacs('sliim')
      .with(cookbook: 'elite')
  end

  it 'syncs git[/home/sliim/.emacs.d]' do
    expect(subject).to sync_git('/home/sliim/.emacs.d')
      .with(user: 'sliim',
            group: 'elite',
            repository: 'https://remote/emacs.d.git',
            reference: 'mybranch',
            enable_submodules: true)
  end

  it 'creates directory[/home/sliim/.dotfiles/eshell]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/eshell')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750')
  end

  it 'creates cookbook_file[/home/sliim/.dotfiles/eshell/alias]' do
    expect(subject).to create_cookbook_file('/home/sliim/.dotfiles/eshell/alias')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'eshell/alias')
  end

  it 'creates elite_dotlink[sliim-eshell]' do
    expect(subject).to create_elite_dotlink('sliim-eshell')
      .with(owner: 'sliim',
            file: 'eshell')
  end

  it 'creates elite_bin[sliim-ec]' do
    expect(subject).to create_elite_bin('sliim-ec')
      .with(owner: 'sliim',
            script: 'ec',
            cookbook: 'elite',
            source_dir: 'bin/')
  end

  it 'creates elite_bin[sliim-ediff-merge-tool]' do
    expect(subject).to create_elite_bin('sliim-ediff-merge-tool')
      .with(owner: 'sliim',
            script: 'ediff-merge-tool',
            cookbook: 'elite',
            source_dir: 'bin/')
  end

  it 'creates elite_desktop_app[eliim-emacs]' do
    expect(subject).to create_elite_desktop_app('sliim-emacs')
      .with(owner: 'sliim',
            app: 'emacs',
            cookbook: 'elite',
            source_dir: 'applications/')
  end

  appdir = '/home/sliim/.dotfiles/local/share/applications'
  it "does not create cookbook_file[#{appdir}/emacs.desktop]" do
    expect(subject).to_not create_cookbook_file("#{appdir}/emacs.desktop")
  end
end
