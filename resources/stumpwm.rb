# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: stumpwm
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
attribute :source, kind_of: String, default: 'stumpwmrc.erb'
attribute :font, kind_of: String, default: '-*bitstream-courier 10 pitch-medium-r-normal-*-10-*-*-*-*-*-*-*'
attribute :wallpaper, kind_of: String, default: 'thc.jpg'
attribute :prefix_key, kind_of: String, default: 's-q'
attribute :pre_commands, kind_of: Array, default: []
attribute :post_commands, kind_of: Array, default: []
attribute :color, kind_of: Hash, default: { 'fg_color' => 'White',
                                            'bg_color' => 'Black',
                                            'focus_color' => 'White',
                                            'border_color' => 'grey15',
                                            'float_focus_color' => 'White',
                                            'float_unfocus_color' => 'gray15',
                                            'grab_pointer_foreground' => 'White',
                                            'grab_pointer_background' => 'Black',
                                          }
attribute :programs, kind_of: Hash, default: {}
attribute :sessions, kind_of: Hash, default: {}
attribute :commands, kind_of: Hash, default: {}

def initialize(*args)
  super
  @action = :create
  @resource_name = :elite_stumpwm
end
