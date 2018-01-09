;;;; keyring.asd
(asdf:defsystem #:keyring
  :serial t
  :description "Gnome Keyring module"
  :author "Sliim <sliim@mailoo.org>"
  :license "GPLv3"
  :depends-on (:stumpwm)
  :components ((:file "package")
               (:file "keyring")))
