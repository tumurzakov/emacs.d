
(use-package org
  :commands (org-mode org-capture org-agenda orgtbl-mode)
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
    ;; Custom Key Bindings

    (require 'org-ehtml)
    (setq org-ehtml-docroot (expand-file-name "~/org"))
    (ws-start org-ehtml-handler 8040)

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

    (setq org-ehtml-allow-agenda nil)

    (setq
     org-hide-leading-stars 1
     org-export-with-planning 1
     org-use-sub-superscripts '{}
     org-export-with-sub-superscripts '{}

     org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))


     ;; Different list levels should use different bullets
     org-list-demote-modify-bullet '(
                                     ("*" . "-")
                                     ("-" . "+")
                                     ("+" . "-")
                                     ("1." . "1)")
                                     ("1)" . "1."))

     org-export-htmlize-output-type 'css

     org-agenda-start-on-weekday nil

     org-html-head "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\" />"

    )

    (defun org-open-link-same-frame ()
      (interactive)
      (if (org-in-regexp org-bracket-link-regexp 1)
      (let ((filename (org-match-string-no-properties 1) ))
        (find-file filename)
        )))

    (defun my-org-clocktable-indent-string (level)
      (if (= level 1) ""
        (let ((str " "))
          (dotimes (k (1- level) str)
            (setq str (concat "……" str))))))
    (advice-add 'org-clocktable-indent-string :override #'my-org-clocktable-indent-string)

    (setq org-agenda-files (quote ("~/org")))

    (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                     (org-agenda-files :maxlevel . 9))))

    ;; project link type
    (org-add-link-type "project" 'org-project-open)

    (defun org-project-open (path)
      "Open project with PATH"
      (funcall 'evil-tabs-tabedit path))

    (setq org-agenda-custom-commands
          (quote
           (
            ("a" "Agenda" agenda "" nil
             ("~/org/agenda.html"))

            ("p" "Priority=A"
             ((tags-todo "+PRIORITY=\"A\""
                         ((org-agenda-overriding-header "Goals")
                          (org-tags-match-list-sublevels nil))))
             nil ("~/org/goals.html")
             )

            ("n" "Agenda and todos" ((agenda "") (alltodo "")) "" nil
             ("~/org/agendaandtodo.html"))

            )
           )
          )

    (add-hook 'org-agenda-mode-hook
              (lambda ()
                (org-save-all-org-buffers)

                (local-unset-key (kbd "$"))

                (define-key org-agenda-mode-map "j" 'evil-next-line)
                (define-key org-agenda-mode-map "k" 'evil-previous-line)
                (define-key org-agenda-mode-map "h" 'evil-backward-char)
                (define-key org-agenda-mode-map "l" 'evil-forward-char)
                (define-key org-agenda-mode-map "$" 'evil-end-of-visual-line)
                (define-key org-agenda-mode-map "0" 'evil-beginning-of-visual-line)
                (define-key org-agenda-mode-map (kbd "C-w C-w") 'windmove-left)
                ))

    (add-hook 'org-mode-hook
              (lambda()
                (local-unset-key (kbd "C-c C-f"))
                (define-key org-mode-map (kbd "C-c C-f") 'org-open-link-same-frame)
                ))
    )
  )

(provide 'my-org)
