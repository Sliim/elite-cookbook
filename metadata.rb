# -*- coding: utf-8 -*-

name 'elite'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache-2.0'
description 'The Elite Cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12.5' if respond_to?(:chef_version)
version '0.7.0'

recipe 'elite::ack', 'Installs/configures Ack'
recipe 'elite::bash', 'Configures Bash'
recipe 'elite::bin', 'Deploy user\'s bin script'
recipe 'elite::cask', 'Installs/configures Cask'
recipe 'elite::chef', 'Installs/configures Chef'
recipe 'elite::compton', 'Installs/configures Compton'
recipe 'elite::conky', 'Installs/configures conky'
recipe 'elite::conky_dzen2', 'configures conky with Dzen2'
recipe 'elite::default', 'Creates elite groups and users'
recipe 'elite::docker_host', 'Installs and configures a Docker host'
recipe 'elite::dotfiles', 'Manage user\'s dotfiles'
recipe 'elite::dotfiles_commit', 'Commit in the user\'s dotfiles repo'
recipe 'elite::dunst', 'Installs/configures Dunst'
recipe 'elite::dzen2', 'Installs Dzen2'
recipe 'elite::emacs', 'Installs/configures Emacs'
recipe 'elite::git', 'Installs/configures Git'
recipe 'elite::gtk', 'Installs/configures Gtk2'
recipe 'elite::irssi', 'Installs/configures Irssi client'
recipe 'elite::moc', 'Installs/configures MOC (Music On Console)'
recipe 'elite::packages', 'Install packages list'
recipe 'elite::pentestenv', 'Installs/configures pentest-env'
recipe 'elite::pics', 'Deploy user\'s pics'
recipe 'elite::python', 'Installs python runtimes and packages from attributes'
recipe 'elite::rofi', 'Installs Rofi'
recipe 'elite::slim', 'Installs/configures SLiM'
recipe 'elite::stuff', 'Deploy Elite stuff repo'
recipe 'elite::stumpwm', 'Installs/configures StumpWM'
recipe 'elite::terminfo', 'Deploy terminfo user\'s directory'
recipe 'elite::tmux', 'Installs/configures Tmux'
recipe 'elite::x', 'Installs/configures Xorg'
recipe 'elite::zsh', 'Installs/configures Zsh'

depends 'apt'
depends 'docker'
depends 'dunst'
depends 'git'
depends 'poise-python'
depends 'pentestenv'

supports 'debian', '> 8.0'
supports 'ubuntu', '= 16.04'

source_url 'https://github.com/Sliim/elite-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/Sliim/elite-cookbook/issues' if
    respond_to?(:issues_url)
