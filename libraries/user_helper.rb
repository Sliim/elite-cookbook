# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Library:: user_helper
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

def user_config(user, key)
  return nil unless node['elite'][user]
  node['elite'][user][key]
end

def user_name(user)
  username = ''
  if node['elite'][user] && node['elite'][user].key?('name')
    username = node['elite'][user]['name']
  end
  username = user.capitalize if username.empty?

  node.override['elite'][user]['name'] = username
  username
end

def user_group(user)
  group = ''
  groups = []
  if node['elite'][user]
    group = node['elite'][user]['group'] if node['elite'][user].key?('group')
    groups = node['elite'][user]['groups'] if node['elite'][user].key?('groups')
  end
  group = user if group.empty?

  groups << group unless groups.include?(group)
  node.override['elite'][user]['group'] = group
  node.override['elite'][user]['groups'] = groups
  group
end

def user_home(user)
  home = ''
  if node['elite'][user] && node['elite'][user].key?('home')
    home = node['elite'][user]['home']
  end
  home = '/root' if user == 'root'
  home = "/home/#{user}" if home.empty?

  node.override['elite'][user]['home'] = home
  home
end

def user_dotfiles(user)
  dotfiles = ''
  if node['elite'][user] && node['elite'][user].key?('dotfd')
    dotfiles = node['elite'][user]['dotfd']
  end
  dotfiles = "#{user_home user}/.dotfiles" if dotfiles.empty?

  node.override['elite'][user]['dotfd'] = dotfiles
  dotfiles
end

def user_shell(user)
  shell = ''
  if node['elite'][user] && node['elite'][user].key?('shell')
    shell =  node['elite'][user]['shell']
  end
  shell = '/bin/sh' if shell.empty?

  node.override['elite'][user]['shell'] = shell
  shell
end
