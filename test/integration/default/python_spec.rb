# -*- coding: utf-8 -*-

describe command 'python --version' do
  its(:exit_status) { should eq 0 }
end

describe command 'python3 --version' do
  its(:exit_status) { should eq 0 }
end

describe command 'pip3 freeze' do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^PyYAML==/) }
end
