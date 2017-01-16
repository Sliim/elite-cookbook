# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: pics
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
  user = new_resource.user

  directory "#{node['elite'][user]['dotfd']}/pics/scrot" do
    owner user
    group node['elite'][user]['group']
    mode '0750'
    recursive true
  end

  node['elite'][user]['pics'].each do |pic|
    elite_picture pic do
      owner user
    end
  end

  elite_dotlink 'pics' do
    owner user
    dotprefix false
    skip_if_exists true
  end

  new_resource.updated_by_last_action(true)
end