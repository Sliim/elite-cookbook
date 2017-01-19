# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: picture
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
  user = new_resource.owner
  directory "#{node['elite'][user]['dotfd']}/pics" do
    owner user
    group node['elite'][user]['group']
    mode '0750'
  end

  elite_dotlink "#{user}-pics" do
    owner user
    file 'pics'
    dotprefix false
    skip_if_exists true
  end

  cookbook_file "#{node['elite'][user]['dotfd']}/pics/#{new_resource.pic}" do
    owner user
    group node['elite'][user]['group']
    mode '0640'
    cookbook new_resource.cookbook
    source "#{new_resource.source_dir}#{new_resource.pic}"
  end

  new_resource.updated_by_last_action(true)
end
