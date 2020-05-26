(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(solarized-gruvbox-light))
 '(custom-safe-themes
   '("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" default))
 '(helm-boring-buffer-regexp-list
   '("\\*ansi-term\\*" "\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\*vterm.*\\*" "\\*lsp-" "\\*reason-"))
 '(helm-buffer-max-length 50)
 '(helm-ff-file-compressed-list '("gz" "bz2" "zip" "7z" "rar"))
 '(helm-ff-history-max-length 1000)
 '(helm-ff-skip-boring-files nil)
 '(helm-ff-skip-git-ignored-files nil)
 '(helm-ff-up-one-level-preselect nil)
 '(helm-files-save-history-extra-sources
   '("Find" "Locate" "Recentf" "Files from Current Directory" "File Cache"))
 '(helm-swoop-use-fuzzy-match t)
 '(helm-use-undecorated-frame-option t)
 '(kill-do-not-save-duplicates t)
 '(kill-read-only-ok t)
 '(kill-ring-max 200)
 '(lsp-log-io t)
 '(package-selected-packages
   '(lua-mode helm-swoop yasnippet web-mode undo-tree term-projectile solarized-theme slime-company session rspec-mode reason-mode racer nix-mode multiple-cursors magit lsp-ui helm-tramp helm-rg helm-projectile helm-lsp helm-fd helm-company golden-ratio geiser form-feed flycheck fish-mode company-jedi company-flx avy anaphora alchemist lorem-ipsum rustic cargo))
 '(session-globals-include
   '((kill-ring 100 t)
     (session-file-alist 100 t)
     (file-name-history 200 t)
     search-ring regexp-search-ring))
 '(session-globals-max-size 1000)
 '(session-globals-max-string 2048)
 '(session-locals-include nil)
 '(session-registers-max-string 2048)
 '(session-use-package t nil (session))
 '(vterm-eval-cmds
   '(("find-file" find-file)
     ("message" message)
     ("vterm-rg" vterm-rg)
     ("vterm-clear-scrollback" vterm-clear-scrollback)
     ("man" man))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vterm-color-black ((t (:inherit term-color-yellow))))
 '(vterm-color-blue ((t (:inherit term-color-blue))))
 '(vterm-color-white ((t (:inherit term-color-white)))))
