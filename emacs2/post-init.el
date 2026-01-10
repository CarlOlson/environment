;;; -*- no-byte-compile: t; lexical-binding: t; -*-

;; Libraries I use often
(use-package anaphora :ensure t :defer nil)
(use-package dash :ensure t :defer nil)
(use-package s :ensure t :defer nil)

;; Load this early since it is needed to more easily debug errors.
(minimal-emacs-load-user-init "utils.el")
(minimal-emacs-load-user-init "keybindings.el")
(minimal-emacs-load-user-init "navigation.el")
(minimal-emacs-load-user-init "formatting.el")

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :custom
  (auto-revert-interval 3)
  (auto-revert-remote-files nil)
  (auto-revert-use-notify t)
  (auto-revert-avoid-polling nil)
  (auto-revert-verbose t))

;; Recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(use-package recentf
  :ensure nil
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)

  :custom
  (recentf-auto-cleanup (if (daemonp) 300 'never))
  (recentf-exclude
   (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
         "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
         "\\.7z$" "\\.rar$"
         "COMMIT_EDITMSG\\'"
         "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
         "-autoloads\\.el$" "autoload\\.el$"))

  :config
  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :custom
  (savehist-autosave-interval 600)
  (savehist-additional-variables
   '(kill-ring                        ; clipboard
     register-alist                   ; macros
     mark-ring global-mark-ring       ; marks
     search-ring regexp-search-ring)))

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(use-package saveplace
  :ensure nil
  :commands (save-place-mode save-place-local-mode)
  :hook
  (after-init . save-place-mode)
  :custom
  (save-place-limit 400))

;; Corfu enhances in-buffer completion by displaying a compact popup with
;; current candidates, positioned either below or above the point. Candidates
;; can be selected by navigating up or down.
(use-package corfu
  :ensure t
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  :custom
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  ;; Enable Corfu
  :config
  (global-corfu-mode))

;; Cape, or Completion At Point Extensions, extends the capabilities of
;; in-buffer completion. It integrates with Corfu or the default completion UI,
;; by providing additional backends through completion-at-point-functions.
(use-package cape
  :ensure t
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; The stripspace Emacs package provides stripspace-local-mode, a minor mode
;; that automatically removes trailing whitespace and blank lines at the end of
;; the buffer when saving.
(use-package stripspace
  :ensure t
  :commands stripspace-local-mode
  :hook ((prog-mode . stripspace-local-mode)
         (text-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))
  :custom
  (stripspace-only-if-initially-clean nil)
  (stripspace-restore-column t))

;; Vertico provides a vertical completion interface
(use-package vertico
  :ensure t
  :config
  (vertico-mode))

;; Vertico leverages Orderless' flexible matching capabilities
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package avy
  :ensure t
  :commands (avy-goto-char
             avy-goto-char-2
             avy-next)
  :autoload avy-jump
  :bind (("C-'" . avy-goto-char-2)
         ("M-'" . avy-goto-char-2)
         ("M-f" . avy-find-file)))

(use-package vundo
  :ensure t
  :autoload vundo
  :bind (("C-x u" . vundo)
         :map vundo-mode-map
         ("g" . vundo-forward)))

(use-package which-key
  :ensure nil
  :commands which-key-mode
  :hook (after-init . which-key-mode)
  :custom
  (which-key-idle-delay 1.5)
  (which-key-idle-secondary-delay 0.25)
  (which-key-add-column-padding 1)
  (which-key-max-description-length 40))

(use-package projectile
  :defer 0
  :ensure t
  :config
  (setq projectile-project-types
        (assq-delete-all 'npm projectile-project-types))
  :bind (("C-c f" . projectile-find-file-dwim)
         ("C-c C-f" . projectile-find-file)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-." . mc/mark-next-like-this-word)
         ("C-," . mc/mark-previous-like-this-word)
         ("C-c C-." . mc/mark-all-words-like-this)))

(use-package elisp-mode
  :ensure nil
  :bind (:map emacs-lisp-mode-map
              (("C-c C-l" . eval-buffer)
               ("C-c C-r" . eval-region))))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :custom
  (lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :after lsp-mode
  :ensure t)

(use-package smerge-mode
  :ensure t
  :after (magit hydra)
  :config
  (defhydra unpackaged/smerge-hydra
    (:color pink :hint nil :post (smerge-auto-leave))
    "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
    ("n" smerge-next)
    ("p" smerge-prev)
    ("b" smerge-keep-base)
    ("u" smerge-keep-upper)
    ("U" (lambda ()
           (interactive)
           (smerge-keep-upper)
           (let ((pos (point)))
             (smerge-next)
             (unless (= pos (point))
               (recenter-top-bottom 2)))))
    ("l" smerge-keep-lower)
    ("L" (lambda ()
           (interactive)
           (smerge-keep-lower)
           (let ((pos (point)))
             (smerge-next)
             (unless (= pos (point))
               (recenter-top-bottom 2)))))
    ("a" smerge-keep-all)
    ("RET" smerge-keep-current)
    ("\C-m" smerge-keep-current)
    ("<" smerge-diff-base-upper)
    ("=" smerge-diff-upper-lower)
    (">" smerge-diff-base-lower)
    ("R" smerge-refine)
    ("E" smerge-ediff)
    ("C" smerge-combine-with-next)
    ("r" smerge-resolve)
    ("k" smerge-kill-current)
    ("zz" (lambda ()
            (interactive)
            (save-buffer)
            (bury-buffer))
     "Save and bury buffer" :color blue)
    ("q" nil "cancel" :color blue))
  :hook (magit-diff-visit-file . (lambda ()
                                   (when smerge-mode
                                     (unpackaged/smerge-hydra/body)))))

(use-package ansi-color
  :ensure t
  :after compile
  :hook (compilation-filter . ansi-color-compilation-filter))

(use-package catppuccin-theme
  :if window-system
  :ensure t
  :custom
  (catppuccin-flavor 'latte)
  :config
  (load-theme 'catppuccin :no-confirm))

(use-package server
  :ensure nil
  :commands server-start
  :hook
  (after-init . server-start))

(set-face-attribute 'default nil
                    :height 130 :weight 'normal :family "JuliaMono Nerd Font")

(add-to-list 'auto-mode-alist `(,(rx "/.env" (or eol ".")) . sh-mode))

(when (eq system-type 'gnu/linux)
  (add-to-list 'exec-path "/home/carl/.local/bin")
  (add-to-list 'exec-path "/home/carl/.asdf/shims"))

(run-with-idle-timer 0 nil (lambda () (message "Ready!")))
