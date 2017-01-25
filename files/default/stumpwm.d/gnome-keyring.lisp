;; -*- coding: utf-8 -*-
;;
;; Cookbook Name:: elite
;; Recipe:: stumpwm
;; Module:: gnome-keyring
;;
(let* ((output (run-shell-command "/usr/bin/gnome-keyring-daemon --start" t))
       (lines (loop :for i = 0 :then (1+ j)
                    :as j = (position #\linefeed output :start i)
                    :collect (subseq output i j)
                    :while j)))
  (dolist (line lines)
    (when (> (length line) 0)
      (let ((env-var (loop :for i = 0 :then (1+ j)
                           :as j = (position #\= line :start i)
                           :collect (subseq line i j)
                           :while j)))

        (sb-posix:setenv (car env-var) (cadr env-var) 1)))))
