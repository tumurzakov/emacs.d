(use-package android-mode
  :ensure android-mode
  :commands (android-create-project
             android-start-emulator
             )
  :config
  (progn
    (setq android-mode-sdk-dir "~/Android/Sdk/")
    (add-hook 'gud-mode-hook
              (lambda ()
                (add-to-list 'gud-jdb-classpath "~/Android/Sdk/platforms/android-21/android.jar")))
                
    ))

(provide 'my-android)
