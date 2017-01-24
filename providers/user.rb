# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: user
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
    password new_resource.password unless new_resource.password.nil?
  end

  new_resource.groups.each do |g|
    group g do
      action :modify
      append true
      members [name]
    end
  end
  new_resource.updated_by_last_action(true)
end
