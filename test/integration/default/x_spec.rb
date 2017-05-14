# -*- coding: utf-8 -*-

%w(xorg rxvt-unicode-256color xterm xsel scrot).each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end

describe file '/home/h4x0r/.Xdefaults' do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/Xdefaults' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.terminfo' do
  it { should_not be_file }
end

describe file '/home/h4x0r/.urxvt.d' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/urxvt.d' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/bin/disable-screensaver' do
  it { should be_file }
  it { should be_mode 0750 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.local/share/applications/urxvt.desktop' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.terminfo' do
  it { should_not be_file }
end
