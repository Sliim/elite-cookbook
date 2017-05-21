# -*- coding: utf-8 -*-

describe command 'irssi --version' do
  its(:stdout) { should match(/irssi /) }
end

describe file '/home/h4x0r/.irssi' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/irssi' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.irssi/config' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.irssi/startup' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.irssi/scripts' do
  it { should be_directory }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.irssi' do
  it { should_not be_directory }
end
