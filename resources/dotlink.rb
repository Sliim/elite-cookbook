# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: dotlink
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
attribute :owner, kind_of: String
attribute :dotprefix, kind_of: [TrueClass, FalseClass], default: true
attribute :skip_if_exists, kind_of: [TrueClass, FalseClass], default: false

def initialize(*args)
  super
  @action = :create
  @resource_name = :elite_dotlink
end