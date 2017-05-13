# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: git
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

  template "#{user_dotfiles(user)}/gitconfig" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.gitconfig_src
    cookbook new_resource.cookbook
    variables name: new_resource.username,
              email: new_resource.email
  end

  template "#{user_dotfiles(user)}/gitignore" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.gitignore_src
    cookbook new_resource.cookbook
    variables lines: new_resource.gitignore
  end

  elite_dotlink "#{user}-gitconfig" do
    owner user
    file 'gitconfig'
  end

  elite_dotlink "#{user}-gitignore" do
    owner user
    file 'gitignore'
  end
end
