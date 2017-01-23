# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: git
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
  git_config = user_config(u, 'git')
  next unless git_config
  elite_git u do
    username node['elite'][u]['name']
    email node['elite'][u]['email']
    mode git_config['mode'] if git_config['mode']
    cookbook git_config['cookbook'] if git_config['cookbook']
    gitconfig_src git_config['gitconfig_src'] if git_config['gitconfig_src']
    gitignore_src git_config['gitignore_src'] if git_config['gitignore_src']
    gitignore git_config['gitignore'] if git_config['gitignore']
  end
end
