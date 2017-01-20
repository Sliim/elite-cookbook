# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: stuff
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

include_recipe 'elite::default'

node['elite']['users'].each do |u|
  stuff_config = user_config(u, 'stuff')
  next unless stuff_config
  elite_stuff u do
    install_path stuff_config['install_path'] if stuff_config['install_path']
    repository stuff_config['repository'] if stuff_config['repository']
    reference stuff_config['reference'] if stuff_config['reference']
  end
end
