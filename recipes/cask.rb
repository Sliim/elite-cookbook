# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: cask
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
  cask_config = user_config(u, 'cask')
  next unless cask_config
  elite_cask u do
    repository cask_config['repository'] if cask_config['repository']
    reference cask_config['reference'] if cask_config['reference']
  end
end
