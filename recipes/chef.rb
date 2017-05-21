# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: ack
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

include_recipe 'chef-dk'

node['elite']['users'].each do |u|
  chef = user_config(u, 'chef')
  next unless chef
  elite_chef u do
    mode chef['mode'] if chef['mode']
    cookbook chef['cookbook'] if chef['cookbook']
    client_source chef['client_source'] if chef['client_source']
    stove_source chef['stove_source'] if chef['stove_source']
    client_key_path chef['client_key_path'] if chef['client_key_path']
    node_name chef['node_name'] if chef['node_name']
    chef_server_url chef['chef_server_url'] if chef['chef_server_url']
  end
end
