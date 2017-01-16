# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: dotlink
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

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  owner = new_resource.owner
  name = new_resource.name
  name = ".#{name}" if new_resource.dotprefix
  exists = ::File.exist? "#{node['elite'][owner]['home']}/#{name}"

  link "#{node['elite'][owner]['home']}/#{name}" do
    owner owner
    group node['elite'][owner]['group']
    link_type :symbolic
    to "#{node['elite'][owner]['dotfd']}/#{new_resource.name}"
    only_if { !exists || (exists && !new_resource.skip_if_exists) }
  end

  new_resource.updated_by_last_action(true)
end
