;; Colors!
(use-package zenburn-theme
  :ensure zenburn-theme
  :config
  (progn
    (load-theme 'zenburn t)))

(global-hl-line-mode t)
(set-face-background 'hl-line "#3e4446")

(use-package smart-mode-line
  :ensure smart-mode-line
  :config
  (progn
    (setq sml/theme 'dark)
    (sml/setup)
    ))

(use-package rainbow-mode
  :ensure rainbow-mode)

(use-package rainbow-delimiters
  :ensure rainbow-delimiters
  :init
  (progn
    (global-rainbow-delimiters-mode)
    )
  )

(setq whitespace-style '(trailing))
(global-whitespace-mode 1)

(use-package nlinum
  :commands nlinum-mode
  :init (nlinum-mode)
  )

(use-package windsize
  :ensure windsize
  :init
  (progn
    (setq windsize-cols 16)
    (setq windsize-rows 8)
    (windsize-default-keybindings)
    )
  )

;; mouse scrolling in terminal
;; is this eyecandy?
(unless (display-graphic-p)
  (global-set-key [mouse-4] (bind (scroll-down 1)))
  (global-set-key [mouse-5] (bind (scroll-up 1))))

;; restore my blood pressure to normal: stop having fill-column=3 in help mode

(add-hook 'help-mode-hook
          (lambda ()
            (set-fill-column 80)))

(use-package powerline
  :ensure powerline
  :demand powerline
  :init
  (progn
    ;; Something's b0rken here; just require it also.
    (require 'powerline)
    (powerline-default-theme)
    )
  )

(provide 'my-eyecandy)
