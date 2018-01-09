;;;; autosplit.asd
(asdf:defsystem #:autosplit
  :serial t
  :description "Autosplit module"
  :author "Sliim <sliim@mailoo.org>"
  :license "GPLv3"
  :depends-on (:stumpwm)
  :components ((:file "package")
               (:file "autosplit")))
