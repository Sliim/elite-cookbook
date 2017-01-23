# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: pics
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
  pics = user_config(u, 'pics')
  next unless pics
  elite_pics u do
    cookbook pics['cookbook'] if pics['cookbook']
    source_dir pics['source_dir'] if pics['source_dir']
    pics pics['pics'] if pics['pics']
  end
end
