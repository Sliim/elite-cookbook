# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: tmux_script
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

resource_name :elite_tmux_script
provides :elite_tmux_script
default_action :create

property :path, String
property :owner, String
property :workdir, String, default: ''
property :environment, Hash, default: {}
property :windows, Hash, default: {}
property :default_window, String, default: '0'
property :source, String, default: 'tmux-script.erb'
property :cookbook, String, default: 'elite'
property :mode, String, default: '0750'

def whyrun_supported?
  true
end

action :create do
  user = new_resource.owner
  workdir = new_resource.workdir
  workdir = user_home(user) if workdir.empty?

  template new_resource.path do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables script: new_resource,
              workdir: workdir,
              name: new_resource.name,
              windows: new_resource.windows,
              default_window: new_resource.default_window,
              environment: new_resource.environment
  end
end
