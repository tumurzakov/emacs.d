
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
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

    (setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
        ("NEXT" :foreground "blue" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("WAITING" :foreground "orange" :weight bold)
        ("HOLD" :foreground "magenta" :weight bold)
        ("CANCELLED" :foreground "forest green" :weight bold)
        ("MEETING" :foreground "forest green" :weight bold)
        ("PHONE" :foreground "forest green" :weight bold))))

    (setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
        ("WAITING" ("WAITING" . t))
        ("HOLD" ("WAITING") ("HOLD" . t))
        (done ("WAITING") ("HOLD"))
        ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
        ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
        ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

    (setq org-default-notes-file "~/org/inbox.org")

    (setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/inbox.org")
       "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
       ("n" "note" entry (file "~/org/inbox.org")
        "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        )))

    (setq org-agenda-files (quote ("~/org")))

    (setq org-refile-targets (quote ((nil :maxlevel . 9)
        (org-agenda-files :maxlevel . 9))))

  )
)

(provide 'my-org)
