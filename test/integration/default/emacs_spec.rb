# -*- coding: utf-8 -*-

describe command 'emacs --help' do
  its(:stdout) { should match(/Usage: emacs \[OPTION-OR-FILENAME\]/) }
end

describe file '/home/h4x0r/.emacs.d' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.emacs.d/.git/modules' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.emacs.d' do
  it { should_not be_directory }
end

describe file '/home/h4x0r/.emacs.d/.cask' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.eshell' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/eshell' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.eshell' do
  it { should_not be_file }
end

describe file '/home/h4x0r/bin/ec' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/bin/ediff-merge-tool' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.local/share/applications/emacs.desktop' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.emacs-apps' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.emacs-apps/.git' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.emacs-apps/Cask' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.local/share/applications/dired.desktop' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.local/share/applications/magit.desktop' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end
