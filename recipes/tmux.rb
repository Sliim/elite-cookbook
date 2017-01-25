# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: tmux
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

package 'tmux'

node['elite']['users'].each do |u|
  tmux_config = user_config(u, 'tmux')
  next unless tmux_config
  elite_tmux u do
    mode tmux_config['mode'] if tmux_config['mode']
    cookbook tmux_config['cookbook'] if tmux_config['cookbook']
    source tmux_config['source'] if tmux_config['source']
    color tmux_config['color'] if tmux_config['color']
    status tmux_config['status'] if tmux_config['status']
    scripts tmux_config['scripts'] if tmux_config['scripts']
  end
end
