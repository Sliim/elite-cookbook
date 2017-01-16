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
end
