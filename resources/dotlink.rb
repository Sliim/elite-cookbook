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

resource_name :elite_dotlink
provides :elite_dotlink
default_action :create

property :file, String, name_property: true
property :owner, String
property :dotprefix, [TrueClass, FalseClass], default: true
property :skip_if_exists, [TrueClass, FalseClass], default: false

def whyrun_supported?
  true
end

action :create do
  owner = new_resource.owner
  file = new_resource.file
  file = ".#{file}" if new_resource.dotprefix
  exists = ::File.exist? "#{user_home(owner)}/#{file}"

  link "#{user_home(owner)}/#{file}" do
    owner owner
    group user_group(owner)
    link_type :symbolic
    to "#{user_dotfiles(owner)}/#{new_resource.file}"
    only_if { !exists || (exists && !new_resource.skip_if_exists) }
  end
end
