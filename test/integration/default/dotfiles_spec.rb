# -*- coding: utf-8 -*-

describe file '/home/h4x0r/.dotfiles' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.dotfiles' do
  it { should_not be_directory }
end

describe command 'ack-grep --help' do
  its(:stdout) { should match(/Usage:/) }
  its(:exit_status) { should eq 0 }
end
