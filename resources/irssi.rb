# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: irssi
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
resource_name :elite_irssi

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :cookbook, kind_of: String, default: 'elite'
attribute :config_source, kind_of: String, default: 'irssi/config.erb'
attribute :scripts_source, kind_of: String, default: 'irssi/scripts'
attribute :mode, kind_of: String, default: '0640'
attribute :startup, kind_of: Array, default: []
attribute :servers, kind_of: Array, default: []
attribute :channels, kind_of: Array, default: []
attribute :chatnets, kind_of: Array, default: []
attribute :aliases, kind_of: Hash, default: {}
attribute :settings, kind_of: Hash, default: {}
attribute :hilights, kind_of: Array, default: []
