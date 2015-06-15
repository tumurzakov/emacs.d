(use-package auto-highlight-symbol
  :ensure auto-highlight-symbol
  :init
  (progn
     (require 'auto-highlight-symbol)
     (global-auto-highlight-symbol-mode t)
    ))

(use-package php-mode
  :ensure php-mode
  :init
    (require 'php-mode)
  )

(use-package web-mode
  :ensure web-mode
  :init
    (require 'web-mode)
  )

(provide 'my-php)
