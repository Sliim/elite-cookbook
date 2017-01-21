# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: default
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

node['elite']['groups'].each do |g|
  group g
end

node['elite']['users'].each do |u|
  next unless node['elite'].key?(u)
  elite_user u do
    home user_config(u, 'home') if user_config(u, 'home')
    shell user_config(u, 'shell') if user_config(u, 'shell')
    password user_config(u, 'password') if user_config(u, 'password')
    groups user_config(u, 'groups') if user_config(u, 'groups')
  end
end
