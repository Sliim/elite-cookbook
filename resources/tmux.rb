# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: tmux
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

resource_name :elite_tmux
provides :elite_tmux
default_action :create

property :user, String, name_property: true
property :mode, String, default: '0640'
property :cookbook, String, default: 'elite'
property :source, String, default: 'tmux.conf.erb'
property :prefix, String, default: 'C-q'
property :options, Hash, default: {}
property :kbd, Hash, default: {}

property :color, Hash, default: { 'pane_border_fg' => 'default',
                                  'pane_border_bg' => 'default',
                                  'pane_active_border_fg' => 'white',
                                  'pane_active_border_bg' => 'default',
                                  'status_fg' => 'default',
                                  'status_bg' => 'black',
                                  'status_current_fg' => 'white',
                                  'status_current_bg' => 'black',
                                  'message_fg' => 'brightred',
                                  'message_bg' => 'black',
                                }
property :status, Hash, default: { 'interval' => 1,
                                   'commands' => {},
                                 }
property :scripts, Hash, default: {}

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  template "#{user_dotfiles(user)}/tmux.conf" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables color: new_resource.color,
              status: new_resource.status,
              prefix: new_resource.prefix,
              options: new_resource.options,
              kbd: new_resource.kbd
  end

  elite_dotlink "#{user}-tmux.conf" do
    owner user
    file 'tmux.conf'
  end

  new_resource.scripts.each do |name, script|
    elite_tmux_script name do
      owner user
      path script['path'] if script['path']
      default_window script['default_window'] if script['default_window']
      windows script['windows'] if script['windows']
      workdir script['workdir'] if script['workdir']
      environment script['environment'] if script['environment']
    end
  end
end
