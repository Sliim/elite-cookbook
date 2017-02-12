# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: configd
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

  execute 'move-user-configd-dir' do
    command "mv #{user_home(user)}/.config #{user_dotfiles(user)}/config"
    action :run
    only_if { ::File.directory? "#{user_home(user)}/.config" }
  end

  directory "#{user_dotfiles(user)}/config" do
    owner user
    group user_group(user)
    mode '0750'
  end

  elite_dotlink "#{user}-configd" do
    owner user
    file 'config'
  end

  new_resource.updated_by_last_action(true)
end
