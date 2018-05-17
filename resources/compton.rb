# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: compton
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

resource_name :elite_compton
provides :elite_compton
default_action :create

property :user, String, name_property: true
property :mode, String, default: '0640'
property :cookbook, String, default: 'elite'
property :source, String, default: 'ini.erb'
property :config, Hash, default: {}

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  elite_configd user

  template "#{user_dotfiles(user)}/config/compton.conf" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables config: new_resource.config
  end
end
