# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: gtk
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

['libgtk2.0-0', 'libgtk2.0-dev', 'gtk2-engines', 'gtk2-engines-pixbuf',
 'gtk2-engines-murrine', 'python-gconf'].each do |pkg|
  package pkg
end

node['elite']['users'].each do |u|
  gtk = user_config(u, 'gtk')
  next unless gtk
  elite_gtk u do
    user u
    cookbook gtk['cookbook'] if gtk['cookbook']
    source gtk['source'] if gtk['source']
    font_name gtk['font_name'] if gtk['font_name']
    theme_name gtk['theme_name'] if gtk['theme_name']
    theme_rc gtk['theme_rc'] if gtk['theme_rc']
    icon_theme_name gtk['icon_theme_name'] if gtk['icon_theme_name']
    toolbar_style gtk['toolbar_style'] if gtk['toolbar_style']
    toolbar_icon_size gtk['toolbar_icon_size'] if gtk['toolbar_icon_size']
    color gtk['color'] if gtk['color']
  end
end
