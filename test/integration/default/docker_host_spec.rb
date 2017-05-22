# -*- coding: utf-8 -*-

describe service 'docker' do
  it { should be_enabled }
  it { should be_running }
end

describe group 'docker' do
  it { should exist }
end

describe user 'h4x0r' do
  its('groups') { should include 'docker' }
end

describe user 'root' do
  its('groups') { should_not include 'docker' }
end

describe file '/usr/local/bin/ctop' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'docker' }
end
