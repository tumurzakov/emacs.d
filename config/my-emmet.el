(use-package emmet-mode
  :ensure emmet-mode
  :init
  (progn
    (require 'emmet-mode)
    (add-hook 'sgml-mode-hook 'emmet-mode)
    (add-hook 'html-mode-hook 'emmet-mode)
    (add-hook 'xml-mode-hook 'emmet-mode)
    (add-hook 'css-mode-hook 'emmet-mode)
    (add-hook 'web-mode-hook 'emmet-mode)
  ))


(provide 'my-emmet)
