# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: irssi
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

package 'irssi'

node['elite']['users'].each do |u|
  irssi = user_config(u, 'irssi')
  next unless irssi
  elite_irssi u do
    mode irssi['mode'] if irssi['mode']
    cookbook irssi['cookbook'] if irssi['cookbook']
    scripts_source irssi['scripts_source'] if irssi['scripts_source']
    config_source irssi['config_source'] if irssi['config_source']
    startup_source irssi['startup_source'] if irssi['startup_source']
    mode irssi['mode'] if irssi['mode']
    startup irssi['startup'] if irssi['startup']
    servers irssi['servers'] if irssi['servers']
    channels irssi['channels'] if irssi['channels']
    chatnets irssi['chatnets'] if irssi['chatnets']
    aliases irssi['aliases'] if irssi['aliases']
    settings irssi['settings'] if irssi['settings']
    hilights irssi['hilights'] if irssi['hilights']
  end
end
