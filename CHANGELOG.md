elite CHANGELOG
=================

This file is used to list changes made in each version of the elite cookbook.

0.4.0
-----
- Changes:
  - `elite::x` take now rofi configuration
  - New zsh plugin: `ascii`
  - Removed `stumpwm` bin script
  - `elite::dotfiles` improvements
  - `elite::emacs` can now configures emacs-apps
  - Install cask dependencies when emacs repos synced
- New dependencies:
  - `locales` cookbook
- New attributes:
  - `[elite][locales]`
- New recipes:
  - `elite::rofi` - Install rofi
  - `elite::locales` - Install locales
  - `elite::dotfiles_commit` - Commit in the user's dotfiles repo
- New lwrp:
  - `elite_dotfiles` - Manage user's dotfiles

0.3.0
-----
- Move ~/.config user directory in dotfiles if already exist
- Add gtk themes: Redified, Greenified, Orangified
- Refactored StumpWM setup:
  - Configure commands, font, modules, kbd from attributes or lwrp
  - All setup in ~/.stumpwmrc file
  - Add attribute to checkout contrib repository
- Fixed gtk theme rc template

0.2.0
-----
- Added recipes:
  + `elite::conky`
  + `elite::conky_dzen2`
  + `elite::dunst`
  + `elite::dzen2`
  + `elite::gtk`
  + `elite::slim`
  + `elite::stumpwm`
- Added lwrps:
  + `elite_configd`
  + `elite_sound`
  + `elite_conky`
  + `elite_conky_dzen2`
  + `elite_dunst`
  + `elite_gtk`
  + `elite_stumpwm`

0.1.0
-----
- Initial release of elite cookbook
