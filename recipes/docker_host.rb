# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: docker_host
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

docker_service 'default' do
  action [:create, :start]
  group 'docker'
end

group 'docker' do
  action [:create, :modify]
  system true
  append true
  members node['elite']['docker_host']['users']
end

remote_file '/usr/local/bin/ctop' do
  source node['elite']['docker_host']['ctop_url']
  owner 'root'
  group 'docker'
  mode '0755'
end
