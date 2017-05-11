# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: slim
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

package 'slim'

template '/etc/slim.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'slim.conf.erb'
  variables user: node['elite']['slim']['user'],
            session: node['elite']['slim']['session'],
            theme: node['elite']['slim']['theme']
end

directory '/usr/share/slim/themes' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

node['elite']['slim']['additional_themes'].each do |theme, info|
  git "/usr/share/slim/themes/#{theme}" do
    user 'root'
    group 'root'
    repository info['repository']
    reference info['reference']
    action :sync
  end
end

file '/etc/X11/default-display-manager' do
  content '/usr/bin/slim'
  mode '0644'
  owner 'root'
  group 'root'
end

link '/lib/systemd/system/display-manager.service' do
  link_type :symbolic
  to '/lib/systemd/system/slim.service'
  owner 'root'
  group 'root'
end
