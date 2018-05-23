# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: user
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

resource_name :elite_user
provides :elite_user
default_action :create

property :home, String, default: ''
property :shell, String, default: '/bin/zsh'
property :password, String, default: ''
property :groups, Array, default: []

def whyrun_supported?
  true
end

action :create do
  name = new_resource.name
  home = new_resource.home
  home = user_home name if home.empty?
  shell = new_resource.shell
  shell = user_shell name if shell.empty?

  node.override['elite'][name]['home'] = home
  node.override['elite'][name]['shell'] = shell

  user name do
    home home
    shell shell
    manage_home !::File.exist?(home)
    password new_resource.password unless new_resource.password.empty?
  end

  new_resource.groups.each do |g|
    group g do
      action :modify
      append true
      members [name]
      ignore_failure true
    end
  end
end
