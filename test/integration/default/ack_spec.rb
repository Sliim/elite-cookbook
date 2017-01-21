# -*- coding: utf-8 -*-

describe package 'ack-grep' do
  it { should be_installed }
end

describe file '/home/h4x0r/.ackrc' do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/ackrc' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.ackrc' do
  it { should_not be_file }
end

describe command 'ack-grep --help' do
  its(:stdout) { should match(/Usage:/) }
  its(:exit_status) { should eq 0 }
end
