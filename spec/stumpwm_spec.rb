# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: stumpwm
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

describe 'elite::stumpwm' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_stumpwm elite_stumpwm_module elite_stumpwm_d),
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['email'] = 'sliim@mailoo.org'
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['pics']['cookbook'] = 'elite'
      node.override['elite']['sliim']['pics']['source_dir'] = 'pics/'
      node.override['elite']['sliim']['stumpwm']['font'] = 'font'
      node.override['elite']['sliim']['stumpwm']['wallpaper'] = 'wallpaper-01.jpg'
      node.override['elite']['sliim']['stumpwm']['prefix_key'] = 's-f'
      node.override['elite']['sliim']['stumpwm']['pre_commands'] = ['run-something']
      node.override['elite']['sliim']['stumpwm']['post_commands'] = ['run-another-thing']
      node.override['elite']['sliim']['stumpwm']['color']['fg'] = 'Black'
      node.override['elite']['sliim']['stumpwm']['color']['bg'] = 'White'
      node.override['elite']['sliim']['stumpwm']['color']['focus'] = 'Black'
      node.override['elite']['sliim']['stumpwm']['color']['border'] = 'grey15'
      node.override['elite']['sliim']['stumpwm']['color']['float_focus'] = 'White'
      node.override['elite']['sliim']['stumpwm']['color']['float_unfocus'] = 'Black'
      node.override['elite']['sliim']['stumpwm']['color']['grab_pointer_fg'] = 'White'
      node.override['elite']['sliim']['stumpwm']['color']['grab_pointer_bg'] = 'Black'
      node.override['elite']['sliim']['stumpwm']['programs']['elite']['kbd'] = 's-s'
      node.override['elite']['sliim']['stumpwm']['programs']['elite']['command'] = 'emacs --title Elite'
      node.override['elite']['sliim']['stumpwm']['programs']['elite']['props'] = '(:title "Elite")'
      node.override['elite']['sliim']['stumpwm']['sessions']['pwnage']['kbd'] = 's-p'
      node.override['elite']['sliim']['stumpwm']['sessions']['pwnage']['desc'] = 'Pwnage session'
      node.override['elite']['sliim']['stumpwm']['sessions']['pwnage']['props'] = '(:title "Pwnage")'
      node.override['elite']['sliim']['stumpwm']['sessions']['pwnage']['command'] = 'urxvt -title Pwnage'
      node.override['elite']['sliim']['stumpwm']['sessions']['codz']['kbd'] = 's-c'
      node.override['elite']['sliim']['stumpwm']['sessions']['codz']['desc'] = 'Codz session'
      node.override['elite']['sliim']['stumpwm']['sessions']['codz']['props'] = '(:title "Codz")'
      node.override['elite']['sliim']['stumpwm']['sessions']['codz']['command'] = 'urxvt -title Codz'
      node.override['elite']['sliim']['stumpwm']['commands']['mycmd'] = 'urxvt'
      node.override['elite']['sliim']['stumpwm']['kbd']['*root-map*']['t'] = 'urxvt'
      node.override['elite']['sliim']['stumpwm']['contrib'] = true
      node.override['elite']['sliim']['stumpwm']['modules']['wrapper'] = %w(mymod1 mymod2)
      node.override['elite']['sliim']['stumpwm']['modules']['contrib'] = %w(alert-me)
      node.override['elite']['sliim']['stumpwm']['webjumps']['cookbooks'] = 'https://supermarket.chef.io/cookbooks/'
      node.override['elite']['sliim']['stumpwm']['config'] = { '*timeout-wait*' => 1337 }
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_stumpwm[sliim]' do
    expect(subject).to create_elite_stumpwm('sliim')
      .with(cookbook: 'elite')
  end

  it 'creates elite_stumpwm_d[sliim]' do
    expect(subject).to create_elite_stumpwm_d('sliim')
  end

  it 'creates directory[/home/sliim/.dotfiles/stumpwm.d]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/stumpwm.d')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            recursive: true)
  end

  it 'creates directory[/home/sliim/.dotfiles/stumpwm.d/modules]' do
    expect(subject).to create_directory('/home/sliim/.dotfiles/stumpwm.d/modules')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            recursive: true)
  end

  it 'syncs git[/home/sliim/.dotfiles/stumpwm.d/modules/contrib]' do
    expect(subject).to sync_git('/home/sliim/.dotfiles/stumpwm.d/modules/contrib')
      .with(user: 'sliim',
            group: 'elite',
            repository: 'https://github.com/stumpwm/stumpwm-contrib',
            reference: 'master')
  end

  it 'does not create elite_stumpwm_module[sliim-alert-me]' do
    expect(subject).to_not create_elite_stumpwm_module('sliim-alert-me')
  end

  %w(mymod1 mymod2).each do |m|
    it "creates elite_stumpwm_module[sliim-#{m}]" do
      expect(subject).to create_elite_stumpwm_module("sliim-#{m}")
        .with(owner: 'sliim',
              mod: m,
              cookbook: 'wrapper')
    end

    it "creates directory[/home/sliim/.dotfiles/stumpwm.d/modules/#{m}]" do
      expect(subject).to create_directory("/home/sliim/.dotfiles/stumpwm.d/modules/#{m}")
        .with(owner: 'sliim',
              group: 'elite',
              mode: '0750')
    end

    ['package.lisp', "#{m}.lisp", "#{m}.asd"].each do |f|
      it "creates cookbook_file[/home/sliim/.dotfiles/stumpwm.d/modules/#{m}/#{f}]" do
        expect(subject).to create_cookbook_file("/home/sliim/.dotfiles/stumpwm.d/modules/#{m}/#{f}")
          .with(owner: 'sliim',
                group: 'elite',
                mode: '0640',
                source: "stumpwm.d/modules/#{m}/#{f}",
                cookbook: 'wrapper')
      end
    end
  end

  it 'creates template[/home/sliim/.dotfiles/stumpwmrc]' do
    config_file = '/home/sliim/.dotfiles/stumpwmrc'
    matches = [start_with(';; Generated by Chef!'),
               /^\(set-prefix-key \(kbd "s-f"\)\)$/,
               /run-shell-command "run-something"/,
               /\(setf \*timeout-wait\* 1337/,
               %r{run-shell-command "feh --bg-scale ~/pics/wallpaper-01.jpg"},
               /run-shell-command "run-another-thing"/,
               /screen-fg-color "Black"\)$/,
               /screen-bg-color "White"\)$/,
               /screen-focus-color "Black"\)$/,
               /screen-border-color "grey15"\)$/,
               /screen-float-focus-color "White"\)$/,
               /screen-float-unfocus-color "Black"\)$/,
               /grab-pointer-foreground\* \(lookup-color \(current-screen\) "White"\)/,
               /grab-pointer-background\* \(lookup-color \(current-screen\) "Black"\)/,
               /^\(set-font "font"\)/,
               /^\(defprogram-shortcut elite$/,
               /:key \(kbd "s-s"\)$/,
               /:command "emacs --title Elite"$/,
               /:props \'\(:title "Elite"\)$/,
               /"gnew pwnage"$/,
               /"gnew codz"$/,
               /^\(defcommand pwnage/,
               /"Pwnage session"$/,
               /\(stumpwm:run-commands "gselect pwnage"\)$/,
               /\(run-or-raise "urxvt -title Pwnage" '\(:title "Pwnage"\)\)\)$/,
               /^\(define-key \*top-map\* \(kbd "s-p"\) "pwnage-session"\)$/,
               /^\(defcommand codz/,
               /"Codz session"$/,
               /\(stumpwm:run-commands "gselect codz"\)$/,
               /\(run-or-raise "urxvt -title Codz" '\(:title "Codz"\)\)\)$/,
               /^\(define-key \*top-map\* \(kbd "s-c"\) "codz-session"\)$/,
               /^\(defcommand mycmd \(\) \(\)$/,
               /\(run-shell-command "urxvt"\)/,
               /\(run-shell-command "urxvt"\)/,
               /\(load-module "mymod1"\)$/,
               /\(load-module "mymod2"\)$/,
               /\(load-module "alert-me"\)$/,
               /^\(define-key \*root-map\* \(kbd "t"\) "urxvt"\)$/,
               %r{^\(make-web-jump cookbooks "https://supermarket.chef.io/cookbooks/"\)$},
              ]

    expect(subject).to create_template(config_file)
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'stumpwmrc.erb')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end

  it 'creates elite_desktop_app[sliim-stumpwm-elite-program]' do
    expect(subject).to create_elite_desktop_app('sliim-stumpwm-elite-program')
      .with(owner: 'sliim',
            app: 'stumpwm-elite-program',
            config: {
              'Name' => 'Stumpwm-Elite',
              'GenericName' => 'Stumpwm Elite program (s-s)',
              'Comment' => 'Stumpwm Elite program',
              'Exec' => 'stumpish elite',
              'Terminal' => false,
              'Type' => 'Application',
              'Encoding' => 'UTF-8',
              'Icon' => 'preferences-desktop-display',
              'Categories' => 'StumpWM;Programs'
            })
  end

  it 'creates elite_desktop_app[sliim-stumpwm-pwnage-session]' do
    expect(subject).to create_elite_desktop_app('sliim-stumpwm-pwnage-session')
      .with(owner: 'sliim',
            app: 'stumpwm-pwnage-session',
            config: {
              'Name' => 'Stumpwm-Pwnage',
              'GenericName' => 'Pwnage session (s-p)',
              'Comment' => 'Stumpwm Pwnage session',
              'Exec' => 'stumpish pwnage-session',
              'Terminal' => false,
              'Type' => 'Application',
              'Encoding' => 'UTF-8',
              'Icon' => 'preferences-desktop-display',
              'Categories' => 'StumpWM;Sessions'
            })
  end

  it 'creates elite_dotlink[sliim-stumpwmrc]' do
    expect(subject).to create_elite_dotlink('sliim-stumpwmrc')
      .with(owner: 'sliim',
            file: 'stumpwmrc')
  end

  it 'creates elite_dotlink[sliim-stumpwm.d]' do
    expect(subject).to create_elite_dotlink('sliim-stumpwm.d')
      .with(owner: 'sliim',
            file: 'stumpwm.d')
  end

  it 'creates elite_bin[sliim-stumpish]' do
    expect(subject).to create_elite_bin('sliim-stumpish')
      .with(owner: 'sliim',
            script: 'stumpish',
            cookbook: 'elite',
            source_dir: 'bin/')
  end

  it 'creates elite_picture[sliim-wallpaper-01.jpg]' do
    expect(subject).to create_elite_picture('sliim-wallpaper-01.jpg')
      .with(owner: 'sliim',
            pic: 'wallpaper-01.jpg',
            cookbook: 'elite',
            source_dir: 'pics/')
  end
end
