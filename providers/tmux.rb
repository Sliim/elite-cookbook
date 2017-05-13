# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: tmux
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

use_inline_resources

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
              status: new_resource.status
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
    end
  end
end
