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

include_recipe 'elite::dotfiles'

package 'ack-grep'

node['elite']['users'].each do |u|
  ack_config = user_config(u, 'ack')
  next unless ack_config
  elite_ack u do
    mode ack_config['mode'] if ack_config['mode']
    cookbook ack_config['cookbook'] if ack_config['cookbook']
    source ack_config['source'] if ack_config['source']
    config ack_config['config'] if ack_config['config']
  end
end
