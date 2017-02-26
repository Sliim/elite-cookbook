# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: x
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
attribute :source, kind_of: String, default: 'Xdefaults.erb'
attribute :default_session, kind_of: String, default: 'stumpwm'
attribute :config, kind_of: Hash, default: { 'urxvt' =>
                                             {
                                               'transparent' => false,
                                               'tintColor' => 'White',
                                               'shading' => 30,
                                               'saveLines' => 12_000,
                                               'foreground' => 'White',
                                               'background' => 'Black',
                                               'font' => 'xft:Bitstream Vera Sans Mono:pixelsize=10:antialias=true:hinting=true',
                                               'boldFont' => 'xft:Bitstream Vera Sans Mono:bold:pixelsize=10:antialias=true:hinting=true',
                                               'boldColors' => 'on',
                                               'color4' => 'White',
                                               'color12' => 'White',
                                             },
                                             'xterm' => {
                                               'foreground' => 'white',
                                               'background' => 'black',
                                             },
                                             'dzen2' => {
                                               'font' => 'xft:Bitstream Vera Sans Mono:pixelsize=10:antialias=true:hinting=true',
                                               'foreground' => 'White',
                                               'background' => 'black',
                                             },
                                             'rofi' => {},
                                           }

def initialize(*args)
  super
  @action = :create
  @resource_name = :elite_x
end
