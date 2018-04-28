# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: conky_dzen2
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
include_recipe 'elite::conky'
include_recipe 'elite::dzen2'

node['elite']['users'].each do |u|
  conky_config = user_config(u, 'conky')
  next unless conky_config
  elite_conky_dzen2 u do
    config conky_config['global_config'] if conky_config['global_config']
  end
end
