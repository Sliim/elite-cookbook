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
  ['emacs.d', 'emacs-apps'].each do |d|
    execute "cask-install-#{user}-#{d}" do
      cwd "#{user_home(user)}/.#{d}"
      command 'cask install'
      environment 'PATH' => "#{ENV['PATH']}:#{user_home(user)}/.cask/bin",
                  'HOME' => user_home(user)
      user user
      group user_group(user)
      ignore_failure new_resource.cask_install_ignore_failure
      action :nothing
    end
  end

  git "#{user_home(user)}/.emacs.d" do
    not_if { new_resource.repository.empty? }
    notifies :run, "execute[cask-install-#{user}-emacs.d]"
    user user
    group user_group(user)
    repository new_resource.repository
    reference new_resource.reference
    enable_submodules true
    action :sync
  end

  directory "#{user_dotfiles(user)}/eshell" do
    owner user
    group user_group(user)
    mode '0750'
  end

  cookbook_file "#{user_dotfiles(user)}/eshell/alias" do
    owner user
    group user_group(user)
    mode '0640'
    source 'eshell/alias'
    cookbook new_resource.cookbook
  end

  elite_dotlink "#{user}-eshell" do
    owner user
    file 'eshell'
  end

  %w(ec ediff-merge-tool).each do |bin|
    elite_bin "#{user}-#{bin}" do
      owner user
      script bin
    end
  end

  unless new_resource.apps.empty?
    git "#{user_home(user)}/.emacs-apps" do
      user user
      group user_group(user)
      repository new_resource.apps_repository
      reference new_resource.apps_reference
      notifies :run, "execute[cask-install-#{user}-emacs-apps]"
      action :sync
    end

    template "#{user_home(user)}/.emacs-apps/Cask" do
      not_if { new_resource.apps_dependencies.empty? }
      owner user
      group user_group(user)
      mode '0640'
      cookbook new_resource.cookbook
      source 'emacs-apps/Cask.erb'
      variables deps: new_resource.apps_dependencies
    end

    new_resource.apps.each do |name, config|
      elite_emacs_app "#{user}-#{name}" do
        owner user
        app name
        config config
      end
    end
  end
end
