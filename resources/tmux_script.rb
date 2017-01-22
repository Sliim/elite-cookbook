# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: tmux_script
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
attribute :path, kind_of: String
attribute :owner, kind_of: String
attribute :workdir, kind_of: String, default: ''
attribute :windows, kind_of: Hash, default: {}
attribute :default_window, kind_of: String, default: '0'
attribute :source, kind_of: String, default: 'tmux-script.erb'
attribute :cookbook, kind_of: String, default: 'elite'
attribute :mode, kind_of: String, default: '0750'

def initialize(*args)
  super
  @action = :create
  @resource_name = :elite_tmux_script
end
