# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: stumpwm
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
  stumpwm = user_config(u, 'stumpwm')
  next unless stumpwm
  elite_stumpwm u do
    user u
    cookbook stumpwm['cookbook'] if stumpwm['cookbook']
    source stumpwm['source'] if stumpwm['source']
    wallpaper stumpwm['wallpaper'] if stumpwm['wallpaper']
    prefix_key stumpwm['prefix_key'] if stumpwm['prefix_key']
    pre_commands stumpwm['pre_commands'] if stumpwm['pre_commands']
    post_commands stumpwm['post_commands'] if stumpwm['post_commands']
    color stumpwm['color'] if stumpwm['color']
  end
end
