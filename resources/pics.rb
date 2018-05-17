# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: pics
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

resource_name :elite_pics
provides :elite_pics
default_action :create

property :user, String, name_property: true
property :cookbook, String, default: 'elite'
property :source_dir, String, default: 'pics/'
property :pics, Array, default: []

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  directory "#{user_dotfiles(user)}/pics/scrot" do
    owner user
    group user_group(user)
    mode '0750'
    recursive true
  end

  new_resource.pics.each do |pic|
    elite_picture "#{user}-#{pic}" do
      owner user
      pic pic
      cookbook new_resource.cookbook
      source_dir new_resource.source_dir
    end
  end
end
