# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: conky_dzen2
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
resource_name :elite_conky_dzen2

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :config, kind_of: Hash, default: { 'default_color' => 'FFFFFF',
                                             'color1' => 'FFFFFF',
                                             'color2' => 'AAAAAA',
                                             'color3' => '777777',
                                             'color4' => '444444'
                                           }

attribute :interface_type_blacklist, kind_of: Array, default: []
