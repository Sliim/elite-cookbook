# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: irssi
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

  directory "#{user_dotfiles(user)}/irssi" do
    owner user
    group user_group(user)
    mode '0750'
  end

  remote_directory "#{user_dotfiles(user)}/irssi/scripts" do
    owner user
    group user_group(user)
    mode '0750'
    files_owner user
    files_group user_group(user)
    files_mode new_resource.mode
    source new_resource.scripts_source
  end

  template "#{user_dotfiles(user)}/irssi/startup" do
    owner user
    group user_group(user)
    mode new_resource.mode
    cookbook new_resource.cookbook
    source new_resource.startup_source
    variables lines: new_resource.startup
  end

  template "#{user_dotfiles(user)}/irssi/config" do
    owner user
    group user_group(user)
    mode new_resource.mode
    cookbook new_resource.cookbook
    source new_resource.config_source
    variables servers: new_resource.servers,
              channels: new_resource.channels,
              chatnets: new_resource.chatnets,
              aliases: new_resource.aliases,
              settings: new_resource.settings,
              hilights: new_resource.hilights
  end

  elite_dotlink "#{user}-irssi" do
    owner user
    file 'irssi'
  end
end
