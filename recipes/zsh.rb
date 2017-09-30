# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
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

package 'zsh'

node['elite']['users'].each do |u|
  zsh_config = user_config(u, 'zsh')
  next unless zsh_config
  elite_zsh u do
    user u
    cookbook zsh_config['cookbook'] if zsh_config['cookbook']
    source zsh_config['source'] if zsh_config['source']
    config zsh_config['config'] if zsh_config['config']
    plugins zsh_config['plugins'] if zsh_config['plugins']
    completions zsh_config['completions'] if zsh_config['completions']
    theme zsh_config['theme'] if zsh_config['theme']
    aliases zsh_config['aliases'] if zsh_config['aliases']
  end
end
