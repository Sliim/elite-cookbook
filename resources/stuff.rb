# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: stuff
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

resource_name :elite_stuff
provides :elite_stuff
default_action :create

property :user, String, name_property: true
property :repository, String, default: 'https://github.com/Sliim/elite-stuff.git'
property :reference, String, default: 'master'
property :install_path, String, default: '/opt/elite-stuff'

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user
  install_path = new_resource.install_path
  install_path = "#{user_home(user)}/elite-stuff" if install_path.nil?

  git install_path do
    user user
    group user_group(user)
    repository new_resource.repository
    reference new_resource.reference
    action :sync
  end
end
