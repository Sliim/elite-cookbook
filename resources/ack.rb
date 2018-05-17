# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: ack
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

resource_name :elite_ack
provides :elite_ack
default_action :create

property :user, String, name_property: true
property :mode, String, default: '0640'
property :cookbook, String, default: 'elite'
property :source, String, default: 'list2file.erb'
property :config, Array, default: ['--ignore-dir=.project/',
                                   '--ignore-dir=var/',
                                   '--ignore-dir=log/',
                                   '--ignore-dir=cover/',
                                   '--ignore-dir=logs/',
                                   '--ignore-dir=vendor/',
                                   '--ignore-dir=.cask/',
                                   '--type-set=puppet=.pp,.puppet']

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  template "#{user_dotfiles(user)}/ackrc" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables lines: new_resource.config
  end

  elite_dotlink "#{user}-ackrc" do
    owner user
    file 'ackrc'
  end
end
