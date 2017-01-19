# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: x
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

  %w(xorg rxvt-unicode-256color xterm xsel scrot).each do |pkg|
    package pkg
  end

  template "#{node['elite'][user]['dotfd']}/Xdefaults" do
    owner user
    group node['elite'][user]['group']
    mode '0640'
    cookbook new_resource.cookbook
    source new_resource.source
    variables config: new_resource.config
    notifies :run, 'execute[xrdb-merge]'
  end

  remote_directory "#{node['elite'][user]['dotfd']}/urxvt.d" do
    owner user
    group node['elite'][user]['group']
    mode '0750'
    files_owner user
    files_group node['elite'][user]['group']
    files_mode '0640'
    source 'urxvt.d'
  end

  execute 'xrdb-merge' do
    action :nothing
    command "xrdb -merge #{node['elite'][user]['dotfd']}/Xdefaults"
    user user
    group node['elite'][user]['group']
    ignore_failure true
    environment DISPLAY: ':0.0'
  end

  %w(Xdefaults urxvt.d).each do |link|
    elite_dotlink link do
      owner user
    end
  end

  elite_bin 'disable-screensave.sh' do
    owner user
  end

  elite_desktop_app 'urxvt' do
    owner user
  end

  new_resource.updated_by_last_action(true)
end
