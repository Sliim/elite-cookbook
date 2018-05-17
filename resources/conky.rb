# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: conky
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

resource_name :elite_conky
provides :elite_conky
default_action :create

property :user, String, name_property: true
property :global_config, Hash, default: {}
property :configs, Hash, default: {}

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  ['conky.d', 'conky.d/var', 'conky.d/scripts'].each do |dir|
    directory "#{user_dotfiles(user)}/#{dir}" do
      owner user
      group user_group(user)
      mode '0750'
    end
  end

  elite_dotlink "#{user}-conky" do
    owner user
    file 'conky.d'
  end

  new_resource.configs.each do |name, rc|
    config = rc.key?('config') ? rc['config'] : {}
    text = rc.key?('text') ? rc['text'] : []
    elite_conky_rc "#{user}-#{name}" do
      owner user
      rc name
      config config.merge(new_resource.global_config)
      text text
    end
  end
end
