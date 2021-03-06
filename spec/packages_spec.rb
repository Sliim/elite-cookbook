# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: packages
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

require_relative 'spec_helper'

describe 'elite::packages' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['elite']['packages'] = %w(pkg1 pkg2)
    end.converge(described_recipe)
  end

  %w(pkg1 pkg2).each do |pkg|
    it "installs package[#{pkg}]" do
      expect(subject).to install_package(pkg)
    end
  end
end
