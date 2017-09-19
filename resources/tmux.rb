# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: tmux
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
default_action :create
resource_name :elite_tmux

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :mode, kind_of: String, default: '0640'
attribute :cookbook, kind_of: String, default: 'elite'
attribute :source, kind_of: String, default: 'tmux.conf.erb'
attribute :prefix, kind_of: String, default: 'C-q'
attribute :options, kind_of: Hash, default: {}
attribute :kbd, kind_of: Hash, default: {}

attribute :color, kind_of: Hash, default: { 'pane_border_fg' => 'default',
                                            'pane_border_bg' => 'default',
                                            'pane_active_border_fg' => 'white',
                                            'pane_active_border_bg' => 'default',
                                            'status_fg' => 'default',
                                            'status_bg' => 'black',
                                            'status_current_fg' => 'white',
                                            'status_current_bg' => 'black',
                                            'message_fg' => 'brightred',
                                            'message_bg' => 'black',
                                          }
attribute :status, kind_of: Hash, default: { 'interval' => 1,
                                             'commands' => {},
                                           }
attribute :scripts, kind_of: Hash, default: {}
