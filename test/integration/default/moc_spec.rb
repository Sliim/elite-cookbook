# -*- coding: utf-8 -*-

describe package 'moc' do
  it { should be_installed }
end

describe file '/home/h4x0r/.moc' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/moc' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.moc/config' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.moc' do
  it { should_not be_directory }
end

describe command 'mocp --help' do
  its(:stdout) { should match(/Usage:/) }
  its(:exit_status) { should eq 0 }
end
