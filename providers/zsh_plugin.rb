# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: zsh_plugin
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
  user = new_resource.owner

  directory "#{user_dotfiles(user)}/zsh.d/plugins" do
    owner user
    group user_group(user)
    mode '0750'
  end

  cookbook_file "#{user_dotfiles(user)}/zsh.d/plugins/#{new_resource.plugin}.plugin.zsh" do
    owner user
    group user_group(user)
    mode '0640'
    source "zsh.d/plugins/#{new_resource.plugin}.plugin.zsh"
    cookbook new_resource.cookbook
  end

  new_resource.updated_by_last_action(true)
end
