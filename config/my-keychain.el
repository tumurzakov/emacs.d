;; my-keychain.el
;;
;; Load GPG/SSH keys automatically with keychain.


(use-package keychain-environment
  :ensure keychain-environment
  :init
  (require 'keychain-environment)
  (keychain-refresh-environment))


(provide 'my-keychain)
