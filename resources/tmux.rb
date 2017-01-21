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

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :mode, kind_of: String, default: '0640'
attribute :cookbook, kind_of: String, default: 'elite'
attribute :source, kind_of: String, default: 'tmux.conf.erb'
attribute :color, kind_of: Hash, default: { 'pane-border-fg' => 'default',
                                            'pane-border-bg' => 'default',
                                            'pane-active-border-fg' => 'white',
                                            'pane-active-border-bg' => 'default',
                                            'status-fg' => 'default',
                                            'status-bg' => 'black',
                                            'status-current-fg' => 'white',
                                            'status-current-bg' => 'black',
                                            'message-fg' => 'brightred',
                                            'message-bg' => 'black',
                                          }
attribute :status, kind_of: Hash, default: { 'pyenv_version' => false,
                                             'rbenv_version' => false,
                                             'ndenv_version' => false,
                                           }
attribute :scripts, kind_of: Hash, default: {}

def initialize(*args)
  super
  @action = :create
  @resource_name = :elite_tmux
end
