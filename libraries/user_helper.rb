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

def user_group(user)
  if node['elite'][user] && node['elite'][user].key?('group')
    return node['elite'][user]['group']
  end
  user
end

def user_home(user)
  if node['elite'][user] && node['elite'][user].key?('home')
    return node['elite'][user]['home']
  end

  return '/root' if user == 'root'
  "/home/#{user}"
end

def user_dotfiles(user)
  if node['elite'][user] && node['elite'][user].key?('dotfd')
    return node['elite'][user]['dotfd']
  end
  "#{user_home user}/.dotfiles"
end
