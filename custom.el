(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(avy-all-windows 'all-frames)
 '(avy-background t)
 '(avy-keys '(97 111 101 117 104 116 110 115 105 100))
 '(c-default-style
   '((c-mode . "k&r") (java-mode . "java") (awk-mode . "awk")
     (other . "gnu")))
 '(clean-buffer-list-delay-special 0)
 '(clean-buffer-list-kill-buffer-names
   '("*Help*" "*Apropos*" "*Buffer List*" "*Compile-Log*" "*info*" "*vc*"
     "*vc-diff*" "*diff*" "*helm M-x*" "*helm mini*"
     "*helm-mode-kill-buffer*"))
 '(clean-buffer-list-kill-never-regexps
   '("\\` \\*Minibuf-.*\\*\\'" ".*\\.resi?" ".*\\.rei?" "\\*vterm"))
 '(clean-buffer-list-kill-regexps '("\\`\\*Man " "\\*helm"))
 '(company-begin-commands
   '(self-insert-command org-self-insert-command
                         orgtbl-self-insert-command c-scope-operator
                         c-electric-colon c-electric-lt-gt
                         c-electric-slash delete-backward-word))
 '(company-flx-mode t)
 '(company-insertion-on-trigger nil)
 '(company-tooltip-align-annotations t)
 '(compilation-read-command t)
 '(compilation-scroll-output 'first-error)
 '(create-lockfiles nil)
 '(css-indent-offset 2)
 '(custom-enabled-themes '(catppuccin))
 '(custom-safe-themes
   '("f9d423fcd4581f368b08c720f04d206ee80b37bfb314fa37e279f554b6f415e9"
     "2b0fcc7cc9be4c09ec5c75405260a85e41691abb1ee28d29fcd5521e4fca575b"
     "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633"
     "6e13ff2c27cf87f095db987bf30beca8697814b90cd837ef4edca18bdd381901"
     "c32fbcb7c68d9a3cddf5e213e58afc9c29c55ff3835d10562280e4a690292590"
     "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659"
     "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773"
     "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8"
     "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e"
     "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36"
     "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1"
     "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c"
     "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5"
     "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3"
     "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358"
     "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3"
     "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c"
     "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7"
     default))
 '(display-battery-mode t)
 '(electric-indent-mode nil)
 '(emacs-lisp-mode-hook '(eldoc-mode disable-tabs company-mode))
 '(flymake-show-diagnostics-at-end-of-line nil)
 '(gdscript-docs-force-online-lookup nil)
 '(gdscript-docs-local-path "/home/carl/git/godot-docs-html")
 '(gdscript-docs-use-eww nil)
 '(gdscript-gdformat-line-length 120)
 '(geiser-active-implementations '(chez racket) t)
 '(geiser-chez-binary "chezscheme9.5")
 '(geiser-implementations-alist '(((regexp "\\.rkt$") racket)) t)
 '(git-link-use-commit t)
 '(global-auto-revert-mode t)
 '(global-undo-tree-mode t)
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(helm-M-x-always-save-history t)
 '(helm-boring-buffer-regexp-list
   '("\\*ansi-term\\*" "\\` " "\\`\\*helm" "\\`\\*Echo Area"
     "\\`\\*Minibuf" "\\*vterm.*\\*" "\\*lsp-" "\\*reason-"))
 '(helm-buffer-max-length 50)
 '(helm-ff-cache-mode t)
 '(helm-ff-dynamic-candidate-number-limit nil)
 '(helm-ff-file-compressed-list '("gz" "bz2" "zip" "7z" "rar"))
 '(helm-ff-history-max-length 1000)
 '(helm-ff-skip-boring-files nil)
 '(helm-ff-skip-git-ignored-files nil)
 '(helm-files-save-history-extra-sources
   '("Find" "Locate" "Recentf" "Files from Current Directory"
     "File Cache"))
 '(helm-mode t)
 '(helm-projectile-fuzzy-match t)
 '(helm-rg-default-directory 'git-root)
 '(helm-swoop-use-fuzzy-match t)
 '(helm-use-undecorated-frame-option t)
 '(image-converter nil)
 '(image-use-external-converter t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-major-mode 'emacs-lisp-mode)
 '(key-chord-mode t)
 '(key-chord-one-key-delay 0.15)
 '(key-chord-safety-interval-backward 0.0)
 '(key-chord-safety-interval-forward 0.0)
 '(kill-do-not-save-duplicates t)
 '(kill-read-only-ok t)
 '(kill-ring-max 200)
 '(lsp-log-io nil)
 '(lsp-ui-doc-show-with-cursor t)
 '(lua-indent-level 2)
 '(lua-prefix-key "C-c")
 '(make-backup-files nil)
 '(max-lisp-eval-depth 800)
 '(max-specpdl-size 1600 t)
 '(menu-bar-mode nil)
 '(org-roam-directory "/home/carl/git/org-roam/")
 '(package-selected-packages
   '(anaphora avy catppuccin-theme company flx gdscript-mode git-link
              helm-projectile helm-rg hydra lsp-ui magit multi-vterm
              multiple-cursors nix-mode org-roam prettier reason-mode
              session tempel tide tree-sitter tree-sitter-indent
              tree-sitter-langs typescript-mode undo-tree web-mode
              wgrep yasnippet))
 '(prettier-enabled-parsers
   '(angular babel babel-flow babel-ts css elm espree flow graphql java
             json-stringify less lua html markdown mdx meriyah php
             postgresql pug python ruby scss sh solidity svelte swift
             toml typescript vue xml yaml))
 '(prettier-mode-sync-config-flag nil)
 '(projectile-enable-caching t)
 '(projectile-git-use-fd nil)
 '(projectile-globally-ignored-directories
   '("^\\.idea$" "^\\.vscode$" "^\\.ensime_cache$" "^\\.eunit$"
     "^\\.git$" "^\\.hg$" "^\\.fslckout$" "^_FOSSIL_$" "^\\.bzr$"
     "^_darcs$" "^\\.pijul$" "^\\.tox$" "^\\.svn$" "^\\.stack-work$"
     "^\\.ccls-cache$" "^\\.cache$" "^\\.clangd$" "^\\.yarn$"))
 '(projectile-globally-ignored-file-suffixes '("bs.js" "zip"))
 '(projectile-globally-ignored-files '("TAGS"))
 '(projectile-indexing-method 'alien)
 '(projectile-mode t nil (projectile))
 '(prolog-program-name "/usr/bin/swipl")
 '(prolog-system 'swi)
 '(ring-bell-function 'ignore)
 '(session-globals-include
   '((kill-ring 100 t) (session-file-alist 100 t)
     (file-name-history 200 t) search-ring regexp-search-ring))
 '(session-globals-max-size 1000)
 '(session-globals-max-string 2048)
 '(session-locals-include nil)
 '(session-registers-max-string 2048)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(solarized-distinct-fringe-background t)
 '(solarized-emphasize-indicators nil)
 '(solarized-high-contrast-mode-line t)
 '(solarized-scale-org-headlines nil)
 '(solarized-scale-outline-headlines nil)
 '(solarized-use-less-bold t)
 '(solarized-use-variable-pitch nil)
 '(tide-completion-fuzzy t)
 '(tool-bar-mode nil)
 '(typescript-indent-level 2)
 '(undo-tree-auto-save-history nil)
 '(undo-tree-mode-lighter "")
 '(undo-tree-visualizer-diff nil)
 '(vterm-eval-cmds
   '(("alert-self" alert-self) ("find-file" find-file)
     ("message" message) ("vterm-rg" vterm-rg)
     ("vterm-clear-scrollback" vterm-clear-scrollback)
     ("vterm-fish-killring" vterm-fish-killring) ("man" man)
     ("vterm-fish-killring-base64" vterm-fish-killring-base64)))
 '(vterm-max-scrollback 100000)
 '(warning-suppress-log-types '((lsp-mode) (comp) (server)))
 '(warning-suppress-types '((comp)))
 '(web-mode-attr-indent-offset nil)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-quoted ((t (:inherit default :slant oblique :weight bold))))
 '(vterm-color-black ((t (:inherit term-color-white))))
 '(vterm-color-white ((t (:inherit term-color-black)))))
