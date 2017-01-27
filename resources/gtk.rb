# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: gtk
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

actions :create

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :cookbook, kind_of: String, default: 'elite'
attribute :source, kind_of: String, default: 'gtkrc-2.0.erb'
attribute :font_name, kind_of: String, default: 'sans 8'
attribute :theme_name, kind_of: String, default: 'Cyanized'
attribute :theme_rc, kind_of: String, default: 'gtkrc.erb'
attribute :icon_theme_name, kind_of: String, default: 'ACYL'
attribute :toolbar_style, kind_of: String, default: 'GTK_TOOLBAR_ICONS'
attribute :toolbar_icon_size, kind_of: String, default: 'GTK_ICON_SIZE_SMALL_TOOLBAR'
attribute :color, kind_of: Hash, default: { 'bg_color' => '#0C0C0E',
                                            'selected_bg_color' => '#162C30',
                                            'base_color' => '#0C0C0E',
                                            'fg_color' => '#56BFD2',
                                            'selected_fg_color' => '#00D7FF',
                                            'text_color' => '#56BFD2',
                                            'tooltip_bg_color' => '#F5F5B5',
                                            'tooltip_fg_color' => '#162C30',
                                            'link_color' => '#496B8D',
                                            'panel_bg' => '#0C0C0E',
                                          }

def initialize(*args)
  super
  @action = :create
  @resource_name = :elite_gtk
end
