# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: dotfiles_commit
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

include_recipe 'elite::dotfiles'

node['elite']['users'].each do |u|
  next unless node['elite'].key?(u)
  next unless node['elite'][u].key?('init_repo') && node['elite'][u]['init_repo']

  execute 'dpkg -l > packages.txt' do
    cwd user_dotfiles(u)
    user u
    group user_group(u)
  end

  execute 'git add -A' do
    cwd user_dotfiles(u)
    user u
    group user_group(u)
  end

  execute 'git commit -m "Chef provisionning" --allow-empty' do
    cwd user_dotfiles(u)
    user u
    group user_group(u)
  end
end
