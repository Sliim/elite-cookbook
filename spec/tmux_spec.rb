# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: tmux
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

describe 'elite::tmux' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_tmux elite_tmux_script)) do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['tmux']['color']['pane_border_fg'] = 'pbf-color'
      node.override['elite']['sliim']['tmux']['color']['pane_border_bg'] = 'pbb-color'
      node.override['elite']['sliim']['tmux']['color']['pane_active_border_fg'] = 'pabf-color'
      node.override['elite']['sliim']['tmux']['color']['pane_active_border_bg'] = 'pabb-color'
      node.override['elite']['sliim']['tmux']['color']['status_fg'] = 'sf-color'
      node.override['elite']['sliim']['tmux']['color']['status_bg'] = 'sb-color'
      node.override['elite']['sliim']['tmux']['color']['status_current_fg'] = 'scf-color'
      node.override['elite']['sliim']['tmux']['color']['status_current_bg'] = 'scb-color'
      node.override['elite']['sliim']['tmux']['color']['message_fg'] = 'mf-color'
      node.override['elite']['sliim']['tmux']['color']['message_bg'] = 'mb-color'
      node.override['elite']['sliim']['tmux']['status']['interval'] = 2
      node.override['elite']['sliim']['tmux']['status']['commands'] = { 'Uptime:' => 'uptime',
                                                                        'User:' => 'whoami' }
      node.override['elite']['sliim']['tmux']['prefix'] = 'C-j'
      node.override['elite']['sliim']['tmux']['options'] = { '-g history-limit' => 1337 }
      node.override['elite']['sliim']['tmux']['kbd'] = { 'z' => 'zoom' }
      node.override['elite']['sliim']['tmux']['scripts']['autotmux'] = {
        'path' => '/tmp/autotmux',
        'workdir' => '/tmp',
        'default_window' => '0',
        'environment' => {
          'PATH' => '/bin',
        },
        'windows' => {
          '0' => {
            'name' => 'spec',
            'win' => {
              '0' => 'split-window -h {TARGET}',
              '1' => 'select-pane {TARGET}0',
              '2' => 'split-window -h {TARGET}',
            },
            'cmds' => {
              '0' => 'htop',
              '1' => 'nload',
              '2' => ['pwd', 'ls -la'],
            },
          },
        },
      }
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::default]' do
    expect(subject).to include_recipe('elite::default')
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'creates elite_tmux[sliim]' do
    expect(subject).to create_elite_tmux('sliim')
  end

  it 'does not create elite_tmux[foo]' do
    expect(subject).to_not create_elite_tmux('foo')
  end

  it 'installs package[tmux]' do
    expect(subject).to install_package('tmux')
  end

  it 'creates template[/home/sliim/.dotfiles/tmux.conf]' do
    config_file = '/home/sliim/.dotfiles/tmux.conf'
    matches = [start_with('# Generated by Chef!'),
               /^set -g prefix "C-j"$/,
               /^set -g history-limit 1337$/,
               /^bind z zoom$/,
               /pane-border-fg "pbf-color"$/,
               /pane-border-bg "pbb-color"$/,
               /pane-active-border-fg "pabf-color"$/,
               /pane-active-border-bg "pabb-color"$/,
               /status-interval 2$/,
               /status-fg "sf-color"$/,
               /status-bg "sb-color"$/,
               /message-fg "mf-color"$/,
               /message-bg "mb-color"$/,
               /status-left "#\[fg=sf-color,bg=sb-color\]\[#\[fg=scf-color,bg=scb-color\]#S#\[fg=sf-color,bg=sb-color\]\]"$/,
               /window-status-format "#\[fg=sf-color\]#I#F#W#\[default\]"$/,
               /window-status-current-format "#\[fg=sf-color,bg=sb-color,bold\]\[#\[fg=scf-color,bg=scb-color\]#I#F#W#\[fg=sf-color,bg=sb-color\]\]#\[default\]"$/,
               /status-right "#\[fg=sf-color,bg=sb-color\] \[#\[fg=scf-color,bg=scb-color\]Uptime: #\(uptime\)#\[fg=sf-color,bg=sb-color\]\] \[#\[fg=scf-color,bg=scb-color\]User: #\(whoami\)#\[fg=sf-color,bg=sb-color\]\] \[#\[fg=scf-color,bg=scb-color\]%Y-%m-%d#\[fg=sf-color,bg=sb-color\]\] \[#\[fg=scf-color,bg=scb-color\]%H:%M#\[fg=sf-color,bg=sb-color\]\]"$/]

    expect(subject).to create_template(config_file)
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'tmux.conf.erb',
            cookbook: 'elite')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end

  it 'creates elite_dotlink[sliim-tmux.conf]' do
    expect(subject).to create_elite_dotlink('sliim-tmux.conf')
      .with(owner: 'sliim',
            file: 'tmux.conf')
  end

  it 'creates elite_tmux_script[autotmux]' do
    expect(subject).to create_elite_tmux_script('autotmux')
      .with(owner: 'sliim',
            path: '/tmp/autotmux',
            workdir: '/tmp',
            default_window: '0',
            source: 'tmux-script.erb',
            cookbook: 'elite')
  end

  it 'creates template[/tmp/autotmux]' do
    config_file = '/tmp/autotmux'
    matches = [%(tmux new-session -d -s autotmux -n spec -c /tmp),
               %(tmux set-environment -t autotmux PATH /bin),
               /tmux split-window -h -t autotmux:0.$/,
               /tmux select-pane -t autotmux:0.0$/,
               /tmux-run-cmd "htop" 0 0 autotmux$/,
               /tmux-run-cmd "nload" 0 1 autotmux$/,
               /tmux-run-cmd "pwd" 0 2 autotmux$/,
               /tmux-run-cmd "ls -la" 0 2 autotmux$/]

    expect(subject).to create_template(config_file)
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            source: 'tmux-script.erb',
            cookbook: 'elite')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end
end
