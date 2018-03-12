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
                             version: '9.0') do |node|
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

  it 'does not create template[/home/sliim/.emacs-apps/Cask]' do
    expect(subject).to_not create_template('/home/sliim/.emacs-apps/Cask')
  end

  ['emacs.d', 'emacs-apps'].each do |d|
    it "does nothing execute[cask-install-sliim-#{d}]" do
      resource = subject.execute("cask-install-sliim-#{d}")
      expect(resource).to do_nothing
      expect(resource.user).to match(/^sliim$/)
      expect(resource.group).to match(/^elite$/)
      expect(resource.command).to match(/^cask install$/)
      expect(resource.cwd).to match(%r{^/home/sliim/.#{d}$})
      expect(resource.ignore_failure).to eq false
    end
  end

  context 'with cask_install_ignore_failures option' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: %w(elite_emacs elite_emacs_app),
                               platform: 'debian',
                               version: '9.0') do |node|
        node.override['elite']['users'] = %w(sliim)
        node.override['elite']['groups'] = %w(elite)
        node.override['elite']['sliim']['name'] = 'Sliim'
        node.override['elite']['sliim']['email'] = 'sliim@mailoo.org'
        node.override['elite']['sliim']['home'] = '/home/sliim'
        node.override['elite']['sliim']['emacs']['cask_install_ignore_failure'] = true
      end.converge(described_recipe)
    end

    ['emacs.d', 'emacs-apps'].each do |d|
      it "does nothing execute[cask-install-sliim-#{d}]" do
        resource = subject.execute("cask-install-sliim-#{d}")
        expect(resource).to do_nothing
        expect(resource.ignore_failure).to eq true
      end
    end
  end

  context 'with apps' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: %w(elite_emacs elite_emacs_app),
                               platform: 'debian',
                               version: '9.0') do |node|
        node.override['elite']['users'] = %w(sliim foo)
        node.override['elite']['groups'] = %w(elite)
        node.override['elite']['sliim']['name'] = 'Sliim'
        node.override['elite']['sliim']['email'] = 'sliim@mailoo.org'
        node.override['elite']['sliim']['home'] = '/home/sliim'
        node.override['elite']['sliim']['group'] = 'elite'
        node.override['elite']['sliim']['groups'] = %w(elite)
        node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
        node.override['elite']['sliim']['emacs']['apps_repository'] = 'https://apps.git'
        node.override['elite']['sliim']['emacs']['apps_reference'] = 'myapps'
        node.override['elite']['sliim']['emacs']['apps_dependencies'] = %w(foo bar baz)
        node.override['elite']['sliim']['emacs']['apps']['dired'] = {
          'desktop' => {
            'Name' => 'dired',
            'Icon' => 'emacs',
          },
        }
        node.override['elite']['sliim']['emacs']['apps']['elfeed'] = {
          'feeds' => [
            'https://news.ycombinator.com/rss',
          ],
        }
      end.converge(described_recipe)
    end

    it 'syncs git[/home/sliim/.emacs-apps]' do
      expect(subject).to sync_git('/home/sliim/.emacs-apps')
        .with(user: 'sliim',
              group: 'elite',
              repository: 'https://apps.git',
              reference: 'myapps')
    end

    it 'creates template[/home/sliim/.emacs-apps/Cask]' do
      config_file = '/home/sliim/.emacs-apps/Cask'
      matches = [start_with(';; Generated by Chef!'),
                 /^\(depends-on "foo"\)$/,
                 /^\(depends-on "bar"\)$/,
                 /^\(depends-on "baz"\)$/]

      expect(subject).to create_template(config_file)
        .with(owner: 'sliim',
              group: 'elite',
              mode: '0640',
              cookbook: 'elite',
              source: 'emacs-apps/Cask.erb')

      matches.each do |m|
        expect(subject).to render_file(config_file).with_content(m)
      end
    end

    it 'creates elite_emacs_app[sliim-dired]' do
      expect(subject).to create_elite_emacs_app('sliim-dired')
        .with(owner: 'sliim',
              app: 'dired')
    end

    it 'creates elite_desktop_app[sliim-dired]' do
      expect(subject).to create_elite_desktop_app('sliim-dired')
        .with(owner: 'sliim',
              app: 'dired',
              cookbook: 'elite',
              config: { 'Name' => 'dired', 'Icon' => 'emacs' })
    end

    it 'creates elite_emacs_app[sliim-elfeed]' do
      expect(subject).to create_elite_emacs_app('sliim-elfeed')
        .with(owner: 'sliim',
              app: 'elfeed')
    end

    it 'creates template[/home/sliim/.dotfiles/elfeed.el]' do
      config_file = '/home/sliim/.dotfiles/elfeed.el'
      matches = [start_with(';; Generated by Chef!'),
                 %r{'\("https://news.ycombinator.com/rss"}]

      expect(subject).to create_template(config_file)
        .with(owner: 'sliim',
              group: 'elite',
              mode: '0640',
              source: 'emacs-apps/elfeed.el.erb')

      matches.each do |m|
        expect(subject).to render_file(config_file).with_content(m)
      end
    end
  end
end
