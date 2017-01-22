# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Library:: matchers
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

if defined?(ChefSpec)
  def create_elite_dotlink(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_dotlink, :create, name)
  end

  def create_elite_picture(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_picture, :create, name)
  end

  def create_elite_bin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_bin, :create, name)
  end

  def create_elite_desktop_app(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_desktop_app, :create, name)
  end

  def create_elite_tmux_script(path)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_tmux_script, :create, path)
  end

  def create_elite_zsh_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_zsh_plugin, :create, name)
  end

  def create_elite_zsh_completion(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_zsh_completion, :create, name)
  end

  def create_elite_zsh_theme(name)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_zsh_theme, :create, name)
  end

  def create_elite_user(path)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_user, :create, path)
  end

  def create_elite_bash(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_bash, :create, user)
  end

  def create_elite_cask(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_cask, :create, user)
  end

  def create_elite_ack(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_ack, :create, user)
  end

  def create_elite_pics(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_pics, :create, user)
  end

  def create_elite_git(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_git, :create, user)
  end

  def create_elite_tmux(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_tmux, :create, user)
  end

  def create_elite_zsh(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_zsh, :create, user)
  end

  def create_elite_emacs(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_emacs, :create, user)
  end

  def create_elite_stuff(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_stuff, :create, user)
  end

  def create_elite_terminfo(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_terminfo, :create, user)
  end

  def create_elite_x(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_x, :create, user)
  end

  def create_elite_conky(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_conky, :create, user)
  end

  def create_elite_conky_dzen2(user)
    ChefSpec::Matchers::ResourceMatcher.new(:elite_conky_dzen2, :create, user)
  end
end
