;; -*- coding: utf-8 -*-
;;
;; Cookbook Name:: elite
;; Recipe:: stumpwm
;; Module:: kbd
;;
(defparameter *shift-map* (make-sparse-keymap))
(define-key *root-map* (kbd "ISO_Level3_Shift") '*shift-map*)

(define-key *top-map* (kbd "F11") "exec amixer -c 0 -- sset Master playback 2dB-")
(define-key *top-map* (kbd "F12") "exec amixer -c 0 -- sset Master playback 2dB+")
(define-key *top-map* (kbd "F10") "exec amixer sset Master,0 toggle")

(define-key *top-map* (kbd "s-t") "exec urxvt")
(define-key *top-map* (kbd "C-M-Left") "gprev")
(define-key *top-map* (kbd "C-M-Right") "gnext")
(define-key *top-map* (kbd "C-s-Left") "gprev-with-window")
(define-key *top-map* (kbd "C-s-Right") "gnext-with-window")
(define-key *top-map* (kbd "s-Right") "move-focus Right")
(define-key *top-map* (kbd "s-Left") "move-focus Left")
(define-key *top-map* (kbd "s-Up") "move-focus Up")
(define-key *top-map* (kbd "s-Down") "move-focus Down")
(define-key *top-map* (kbd "s-M-Right") "move-window Right")
(define-key *top-map* (kbd "s-M-Left") "move-window Left")
(define-key *top-map* (kbd "s-M-Up") "move-window Up")
(define-key *top-map* (kbd "s-M-Down") "move-window Down")

(define-key *top-map* (kbd "M-TAB") "exec ~/bin/switcher")

(define-key *root-map* (kbd "-") "vsplit")
(define-key *root-map* (kbd "s--") "hsplit")
(define-key *root-map* (kbd "s") "exec scrot ~/pics/scrot/scrot-%Y-%m-%d_$wx$h%M%s.png")
(define-key *root-map* (kbd "S") "exec scrot -s ~/pics/scrot/scrot-%Y-%m-%d_$wx$h%M%s.png")
(define-key *root-map* (kbd "l") "exec ~/bin/xlock")
(define-key *root-map* (kbd "I") "show-window-properties")
(define-key *root-map* (kbd "f") "toggle-mouse-focus")
(define-key *root-map* (kbd "z") "fullscreen")
