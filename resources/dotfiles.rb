# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: dotfiles
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

resource_name :elite_dotfiles
provides :elite_dotfiles
default_action :create

property :user, String, name_property: true
property :mode, String, default: '0640'
property :cookbook, String, default: 'elite'
property :source, String, default: 'list2file.erb'
property :ignore, Array, default: []
property :init_repo, [TrueClass, FalseClass], default: false

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  directory user_dotfiles(user) do
    owner user
    group user_group(user)
    mode '0750'
    recursive true
  end

  if new_resource.init_repo
    execute 'git init' do
      cwd user_dotfiles(user)
      user user
      group user_group(user)
    end

    execute "git config user.name '#{user_name(user)}'" do
      cwd user_dotfiles(user)
      user user
      group user_group(user)
    end

    execute "git config user.email '#{user_email(user)}'" do
      cwd user_dotfiles(user)
      user user
      group user_group(user)
    end

    template "#{user_dotfiles(user)}/.gitignore" do
      owner user
      group user_group(user)
      cookbook new_resource.cookbook
      source new_resource.source
      mode new_resource.mode
      variables lines: new_resource.ignore
    end
  end
end
