
(use-package org
  :commands (org-mode org-capture org-agenda orgtbl-mode)
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
    ;; Custom Key Bindings
    (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
    (global-set-key (kbd "C-c c") 'org-capture)
    )
  :config
  (progn
    (setq org-todo-keywords
          (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")
                  )))

    (setq org-todo-keyword-faces
          (quote (("TODO" :foreground "red" :weight bold)
                  ("NEXT" :foreground "blue" :weight bold)
                  ("DONE" :foreground "forest green" :weight bold)
                  ("CANCELLED" :foreground "forest green" :weight bold)
                  )))

    (setq org-default-notes-file "~/org/inbox.org")

    (setq org-capture-templates
          (quote (("t" "todo" entry (file "~/org/inbox.org")
                   "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                  ("n" "note" entry (file "~/org/inbox.org")
                   "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                  )))

    (setq org-hide-leading-stars 1)

    (setq org-agenda-files (quote ("~/org")))

    (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                     (org-agenda-files :maxlevel . 9))))

    ;; project link type
    (org-add-link-type "project" 'org-project-open)

    (defun org-project-open (path)
      "Open project with PATH"
      (funcall 'neotree-dir path))

    (add-hook 'org-agenda-mode-hook
              (lambda ()
                (org-save-all-org-buffers)
                ))

    )
  )

(provide 'my-org)
