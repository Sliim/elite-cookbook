# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: stumpwm_module
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

resource_name :elite_stumpwm_module
provides :elite_stumpwm_module
default_action :create

property :mod, String, name_property: true
property :owner, String
property :cookbook, String, default: 'elite'

def whyrun_supported?
  true
end

action :create do
  user = new_resource.owner
  elite_stumpwm_d user

  directory "#{user_dotfiles(user)}/stumpwm.d/modules/#{new_resource.mod}" do
    owner user
    group user_group(user)
    mode '0750'
    recursive true
  end

  ['package.lisp', "#{new_resource.mod}.lisp", "#{new_resource.mod}.asd"].each do |modfile|
    cookbook_file "#{user_dotfiles(user)}/stumpwm.d/modules/#{new_resource.mod}/#{modfile}" do
      owner user
      group user_group(user)
      mode '0640'
      source "stumpwm.d/modules/#{new_resource.mod}/#{modfile}"
      cookbook new_resource.cookbook
    end
  end
end
