;; -*- coding: utf-8 -*-
;;
;; Cookbook Name:: elite
;; Recipe:: stumpwm
;; Module:: command
;;
(in-package :stumpwm)

(defcommand toggle-mouse-focus () ()
  "Toggle between :click, :ignore or :sloppy for mouse-focus-policy."
  (let ((new-value nil))
    (cond
      ((eq *mouse-focus-policy* :click)
       (setf new-value :ignore))
      ((eq *mouse-focus-policy* :ignore)
       (setf new-value :sloppy))
      ((eq *mouse-focus-policy* :sloppy)
       (setf new-value :click)))
    (setf *mouse-focus-policy* new-value)
    (message "*mouse-focus-policy* => ~s" new-value)))

(defcommand firefox () ()
  "Execute firefox shell command."
  (run-shell-command "firefox"))

(defcommand virtualbox () ()
  "Execute virtualbox shell command."
  (run-shell-command "virtualbox"))
