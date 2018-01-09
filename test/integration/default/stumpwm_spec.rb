# -*- coding: utf-8 -*-

# describe command 'stumpwm --help' do
#   its(:stdout) { should match(/Usage: sbcl \[runtime-options\]/) }
# end

describe package 'feh' do
  it { should be_installed }
end

describe file '/home/h4x0r/.stumpwmrc' do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/stumpwmrc' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.stumpwm.d' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/stumpwm.d' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.stumpwm.d/contrib' do
  it { should be_directory }
  it { should be_mode 0755 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.stumpwm.d/contrib' do
  it { should be_directory }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.stumpwm.d/contrib/keyring' do
  it { should be_directory }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.stumpwm.d/contrib/autosplit' do
  it { should be_directory }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

['autosplit/package.lisp', 'autosplit/autosplit.lisp', 'autosplit/autosplit.asd',
 'keyring/package.lisp', 'keyring/keyring.lisp', 'keyring/keyring.asd'].each do |mod|
  describe file "/home/h4x0r/.stumpwm.d/contrib/#{mod}" do
    it { should be_file }
    it { should be_mode 0640 }
    it { should be_owned_by 'h4x0r' }
    it { should be_grouped_into 'elite' }
  end
end

describe file '/home/h4x0r/bin/stumpish' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/usr/share/xsessions/stumpwm.desktop' do
  it { should be_file }
  it { should be_mode 0644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
