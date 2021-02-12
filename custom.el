(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(avy-background t)
 '(avy-keys '(97 111 101 117 104 116 110 115 105 100))
 '(c-default-style
   '((c-mode . "k&r")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu")))
 '(compilation-read-command t)
 '(create-lockfiles nil)
 '(custom-enabled-themes '(solarized-light))
 '(custom-safe-themes
   '("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" default))
 '(geiser-active-implementations '(chez racket))
 '(geiser-chez-binary "chezscheme9.5")
 '(geiser-implementations-alist '(((regexp "\\.rkt$") racket)))
 '(global-undo-tree-mode t)
 '(helm-M-x-always-save-history t)
 '(helm-boring-buffer-regexp-list
   '("\\*ansi-term\\*" "\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\*vterm.*\\*" "\\*lsp-" "\\*reason-"))
 '(helm-buffer-max-length 50)
 '(helm-ff-cache-mode t)
 '(helm-ff-file-compressed-list '("gz" "bz2" "zip" "7z" "rar"))
 '(helm-ff-history-max-length 1000)
 '(helm-ff-skip-boring-files nil)
 '(helm-ff-skip-git-ignored-files nil)
 '(helm-ff-up-one-level-preselect nil)
 '(helm-files-save-history-extra-sources
   '("Find" "Locate" "Recentf" "Files from Current Directory" "File Cache"))
 '(helm-mode t)
 '(helm-rg-default-directory 'git-root)
 '(helm-swoop-use-fuzzy-match t)
 '(helm-use-undecorated-frame-option t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-major-mode 'emacs-lisp-mode)
 '(kill-do-not-save-duplicates t)
 '(kill-read-only-ok t)
 '(kill-ring-max 200)
 '(lsp-log-io t)
 '(lua-indent-level 2)
 '(lua-prefix-key "C-c")
 '(make-backup-files nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(alchemist anaphora avy battle-haxe blacken cargo company-flx company-jedi company-nginx edit-indirect elixir-mode fish-mode flycheck form-feed geiser go-mode golden-ratio haxe-mode helm-company helm-fd helm-lsp helm-projectile helm-rg helm-swoop helm-tramp hsluv link-hint lorem-ipsum lsp-mode lsp-ui lua-mode magit mix multiple-cursors nginx-mode nix-mode racer racket-mode reason-mode rspec-mode rustic session slime-company solarized-theme term-projectile undo-tree use-package web-mode wgrep wgrep-helm yaml-mode yasnippet))
 '(projectile-mode t nil (projectile))
 '(prolog-program-name "/usr/bin/swipl")
 '(prolog-system 'swi)
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
 '(solarized-distinct-fringe-background t)
 '(solarized-emphasize-indicators nil)
 '(solarized-high-contrast-mode-line t)
 '(solarized-scale-org-headlines nil)
 '(solarized-scale-outline-headlines nil)
 '(solarized-use-less-bold t)
 '(solarized-use-variable-pitch nil)
 '(undo-tree-mode-lighter "")
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
 '(vterm-color-black ((t (:inherit term-color-white))))
 '(vterm-color-white ((t (:inherit term-color-black)))))
