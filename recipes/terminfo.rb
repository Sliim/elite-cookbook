# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: terminfo
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
  terminfo_config = user_config(u, 'terminfo')
  next unless terminfo_config
  elite_terminfo u do
    user u
    cookbook terminfo_config['cookbook'] if terminfo_config['cookbook']
    source_dir terminfo_config['source_dir'] if terminfo_config['source_dir']
  end
end
