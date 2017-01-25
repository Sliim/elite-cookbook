# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: x
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

%w(xorg rxvt-unicode-256color xterm xsel scrot feh).each do |pkg|
  package pkg
end

node['elite']['users'].each do |u|
  x_config = user_config(u, 'x')
  next unless x_config
  elite_x u do
    cookbook x_config['cookbook'] if x_config['cookbook']
    source x_config['source'] if x_config['source']
    config x_config['config'] if x_config['config']
  end
end
