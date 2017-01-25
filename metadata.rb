# -*- coding: utf-8 -*-

name 'elite'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache 2.0'
description 'The Elite Cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'elite::ack', 'Installs/configures Ack'
recipe 'elite::bash', 'Configures Bash'
recipe 'elite::bin', 'Deploy user\'s bin script'
recipe 'elite::cask', 'Installs/configures Cask'
recipe 'elite::default', 'Creates elite groups and users'
recipe 'elite::emacs', 'Installs/configures Emacs'
recipe 'elite::git', 'Installs/configures Git'
recipe 'elite::packages', 'Install packages list'
recipe 'elite::pics', 'Deploy user\'s pics'
recipe 'elite::stuff', 'Deploy Elite stuff repo'
recipe 'elite::terminfo', 'Deploy terminfo user\'s directory'
recipe 'elite::tmux', 'Installs/configures Tmux'
recipe 'elite::x', 'Installs/configures Xorg'
recipe 'elite::zsh', 'Installs/configures Zsh'

depends 'apt'
depends 'git'
depends 'dunst'

supports 'debian', '> 8.0'

source_url 'https://github.com/Sliim/elite-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/Sliim/elite-cookbook/issues' if
    respond_to?(:issues_url)
