# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: moc
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

package 'moc'

node['elite']['users'].each do |u|
  moc_config = user_config(u, 'moc')
  next unless moc_config
  elite_moc u do
    mode moc_config['mode'] if moc_config['mode']
    cookbook moc_config['cookbook'] if moc_config['cookbook']
    source moc_config['source'] if moc_config['source']
    config moc_config['config'] if moc_config['config']
  end
end
