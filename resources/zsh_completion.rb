# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: zsh_completion
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

resource_name :elite_zsh_completion
provides :elite_zsh_completion
default_action :create

property :completion, String, name_property: true
property :owner, String
property :cookbook, String, default: 'elite'

def whyrun_supported?
  true
end

action :create do
  user = new_resource.owner

  directory "#{user_dotfiles(user)}/zsh.d/completions" do
    owner user
    group user_group(user)
    mode '0750'
  end

  cookbook_file "#{user_dotfiles(user)}/zsh.d/completions/_#{new_resource.completion}" do
    owner user
    group user_group(user)
    mode '0640'
    source "zsh.d/completions/_#{new_resource.completion}"
    cookbook new_resource.cookbook
  end
end
