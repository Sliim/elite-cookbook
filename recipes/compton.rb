# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: compton
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

package 'compton'

node['elite']['users'].each do |u|
  compton = user_config(u, 'compton')
  next unless compton
  elite_compton u do
    mode compton['mode'] if compton['mode']
    cookbook compton['cookbook'] if compton['cookbook']
    source compton['source'] if compton['source']
    config compton['config'] if compton['config']
  end
end
