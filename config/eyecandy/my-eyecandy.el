
;(use-package zenburn-theme
;   :ensure zenburn-theme
;   :config
;   (progn
;     (unless noninteractive
;     (load-theme 'zenburn t))))

;(use-package professional-theme
;   :ensure professional-theme
;   :config
;   (progn
;     (unless noninteractive
;     (load-theme 'professional t))))

(global-hl-line-mode 0)
(set-face-background 'hl-line "#eee")

;;; Show parentheses
(use-package paren
  :ensure paren
  :init
  (progn
    (require 'paren))
  :config
  (progn
    (show-paren-mode 1)
    (custom-set-faces
     '(show-paren-match ((((class color) (background light)) (:background "#eee")))))
  ))

;; highlight entire expression when matching paren is not visible;
;; otherwise just highlight matching paren
(setq show-paren-style 'mixed)

(setq whitespace-style '(trailing))
(global-whitespace-mode 1)

(use-package smart-mode-line
  :ensure smart-mode-line
  :config
  (progn
    (setq sml/theme 'light)
    (setq sml/mode-width 30)
    (sml/setup)
    ))

(use-package rainbow-mode
  :ensure rainbow-mode)

;(use-package rainbow-delimiters
;  :ensure rainbow-delimiters
;  :idle
;  :init
;  (progn
;    (rainbow-delimiters-mode-enable)
;    ))

;(use-package windsize
;  :ensure windsize
;  :init
;  (progn
;    (setq windsize-cols 16)
;    (setq windsize-rows 8)
;    (windsize-default-keybindings)))

;; restore my blood pressure to normal: stop having fill-column=3 in help mode

(defun my-coding-mode-eyecandy ()
  "Eyecandy specific to programming text editing modes."
  )

;(require 'my-modeline)

(provide 'my-eyecandy)
