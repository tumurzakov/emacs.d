;; my-interaction.el
;;
;; ido, helm, smart emacs navigation, etc.

(use-package helm
  :ensure helm
  :config
  (progn
    (setq helm-command-prefix-key "C-c h")
    (setq helm-quick-update t)
    (use-package helm-swoop
      :ensure helm-swoop)
    (after 'helm-autoloads
      (global-set-key (kbd "C-x C-m") 'helm-M-x)
      (global-set-key (kbd "C-c C-m") 'helm-M-x)
      (after 'evil
        (define-key evil-visual-state-map (kbd "SPC SPC") 'smex)
        (define-key evil-normal-state-map (kbd "SPC SPC") 'smex)
        (define-key evil-normal-state-map (kbd "SPC o")   'helm-imenu)
        (define-key evil-normal-state-map (kbd "SPC e")   'helm-recentf)
        (define-key evil-normal-state-map (kbd "SPC t")   'helm-etags-select)
        (define-key evil-normal-state-map (kbd "SPC l")   'helm-swoop)
        (define-key evil-normal-state-map (kbd "SPC y")   'helm-show-kill-ring)
        (define-key evil-normal-state-map [f5] 'helm-mini)))
    (after 'projectile
      (use-package helm-projectile
        :ensure helm-projectile))
    (after 'flycheck
      (use-package helm-flycheck
        :ensure helm-flycheck))
    )
  )

(use-package ido
  :config
  (progn
    (ido-mode 1)
    (ido-everywhere 1)
    (setq ido-enable-prefix nil)
    (setq ido-use-virtual-buffers t)
    (setq ido-enable-flex-matching t)
    (setq ido-create-new-buffer 'always)
    (setq ido-show-dot-for-dired t)
    (setq ido-confirm-unique-completion nil)
    (setq ido-enable-last-directory-history nil)
    (setq ido-use-filename-at-point 'guess)
    (setq ido-save-directory-list-file
          (concat user-emacs-directory ".cache/ido.last"))
    (use-package ido-ubiquitous
      :ensure ido-ubiquitous)
    (add-hook
     'ido-setup-hook
     (lambda()
       ;; On ido-find-file, let `~` mean `~/` for fastness.
       (define-key ido-file-dir-completion-map "~"
         (lambda ()(interactive)
           (ido-set-current-directory "~/")
           (setq ido-exit 'refresh)
           (exit-minibuffer)))))
    (use-package ido-ubiquitous
      :config
      (progn
        (ido-ubiquitous-mode 1)
        )
      )
    (use-package flx-ido
      :ensure flx-ido
      :defines (ido-cur-item ido-default-item ido-cur-list)
      :config
      (progn
        (flx-ido-mode 1)
        )
      )
    (use-package ido-vertical-mode
      :ensure ido-vertical-mode
      :config
      (progn
        (ido-vertical-mode)
        )
      )
    (after 'evil
      (define-key evil-normal-state-map (kbd "SPC b") 'ibuffer)
      (define-key evil-normal-state-map (kbd "SPC k") 'ido-kill-buffer)
      (define-key evil-normal-state-map (kbd "SPC f") 'ido-find-file)
      )
    )
  )

(use-package ibuffer
  :ensure ibuffer
  :config
  (progn
    (use-package ibuffer-vc
      :ensure ibuffer-vc
      :config (progn
    (setq ibuffer-saved-filter-groups
	   (quote (("default"
                   ("dired" (mode . dired-mode))
                   ("haskell" (mode . haskell-mode))
                   ("python" (mode . python-mode))
                   ("notes" (or
                               (name . "^\\*Calendar\\*$")
                               (name . "^diary$")
                               (mode . org-mode)))
		   ("*buffer*" (name . "\\*.*\\*"))

		   ))))

    )
    )))

(use-package smex
  :ensure smex
  :config
  (progn
    (global-set-key (kbd "M-x") 'smex)
    (setq smex-save-file (concat user-emacs-directory ".cache/smex-items"))
    (smex-initialize)
    ;; the following is from
    ;; http://www.emacswiki.org/emacs/Smex

    ;; typing SPC inserts a hyphen
    (defadvice smex (around space-inserts-hyphen activate compile)
      (let ((ido-cannot-complete-command
             `(lambda ()
                (interactive)
                (if (string= " " (this-command-keys))
                    (insert ?-)
                  (funcall ,ido-cannot-complete-command)))))
        ad-do-it))
    ;; update less often
    (defun smex-update-after-load (unused)
      (when (boundp 'smex-cache)
        (smex-update)))
    (add-hook 'after-load-functions 'smex-update-after-load)
    ))

(use-package ag
  :ensure ag
  :commands (ag ag-mode ag-files ag-regexp-at-point)
  :init
  (progn
    (setq ag-highlight-search t)
    (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))
    (add-hook 'ag-mode-hook (lambda () (linum-mode 0)))
    )
  )

(use-package elisp-slime-nav
  :ensure elisp-slime-nav
  :diminish elisp-slime-nav-mode
  :config
  (progn
    (defun my-lisp-hook ()
      (progn
        (elisp-slime-nav-mode)
        (turn-on-eldoc-mode)))
    (add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
    (add-hook 'lisp-interaction-mode-hook 'my-lisp-hook)
    (add-hook 'ielm-mode-hook 'my-lisp-hook)
    )
  )

(provide 'my-interaction)
