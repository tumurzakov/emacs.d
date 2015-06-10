;; my-projects.el
;;
;; Stuff related to maintaining and navigating around projects.
;; projectile, etc.

;;(use-package etags-select
;;  :ensure etags-select
;;  :init
;;  (setq etags-select-go-if-unambiguous t)
;;  )

(use-package projectile
  :ensure projectile
  :diminish projectile-mode
  :config
  (progn
    (setq projectile-indexing-method 'alien)
    (setq projectile-enable-caching t)
    (setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
    (setq projectile-known-projects-file (concat user-emacs-directory "projectile-bookmarks.eld"))
    (add-to-list 'projectile-globally-ignored-directories "elpa")
    (add-to-list 'projectile-globally-ignored-directories ".cache")
    (add-to-list 'projectile-globally-ignored-directories "node_modules")
    (projectile-global-mode 1)
    ;; automatically dired in projectile-switch-project
    (setq projectile-switch-project-action 'projectile-dired)
    (setq projectile-completion-system 'ido)
    (setq projectile-globally-ignored-directories
          '(".idea"
            ".eunit"
            ".git"
            ".hg"
            ".fslckout"
            ".bzr"
            "_darcs"
            ".tox"
            ".svn"
            "build")
          )
    (after 'evil
      (define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
      )
    )
  )

(use-package neotree
  :ensure neotree
  :config
  (progn

    (defun neotree-open-tab (arg)
      (interactive "P")
      (evil-tabs-tabedit arg))

    (defun neo-buffer--insert-header ()
      (let ((start (point)))
        (set-text-properties start (point) '(face neo-header-face)))
      (neo-buffer--newline-and-begin))

    (after 'evil
    (define-key evil-normal-state-map (kbd "`") 'neotree-toggle)
    (evil-set-initial-state 'neotree-mode 'normal)
    (evil-define-key 'normal neotree-mode-map
      (kbd "RET") 'neotree-enter
      (kbd "c")   'neotree-create-node
      (kbd "r")   'neotree-rename-node
      (kbd "d")   'neotree-delete-node
      (kbd "j")   'neotree-next-line
      (kbd "k")   'neotree-previous-line
      (kbd "SPC") 'neotree-change-root
      (kbd "q")   'neotree-hide
      (kbd "l")   'neotree-enter
      (kbd "t")   'neotree-open-tab
      )
    )
    ))

(provide 'my-projects)
