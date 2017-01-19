# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: emacs
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

  git "#{node['elite'][user]['home']}/.emacs.d" do
    not_if { node['elite'][user]['emacs']['repository'].empty? }
    user user
    group node['elite'][user]['group']
    repository node['elite'][user]['emacs']['repository']
    reference node['elite'][user]['emacs']['reference']
    enable_submodules true
    action :sync
  end

  directory "#{node['elite'][user]['dotfd']}/eshell" do
    owner user
    group node['elite'][user]['group']
    mode '0750'
  end

  cookbook_file "#{node['elite'][user]['dotfd']}/eshell/alias" do
    owner user
    group node['elite'][user]['group']
    mode '0640'
    source 'eshell/alias'
  end

  elite_dotlink 'eshell' do
    owner user
  end

  %w(ec ediff-merge-tool).each do |bin|
    elite_bin bin do
      owner user
    end
  end

  elite_desktop_app 'emacs' do
    owner user
  end

  new_resource.updated_by_last_action(true)
end
