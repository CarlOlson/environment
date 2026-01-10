;;; -*- lexical-binding: t; -*-

(setq custom-file "~/git/environment/custom.el")
(load custom-file)

(setq package-archives
      '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(setq package-archive-priorities
      '(("gnu-elpa" . 3)
        ("melpa" . 2)
        ("nongnu" . 1)))

;; (eval-and-compile
;;  (package-refresh-contents)
;;  (package-initialize))

;; (require 'use-package)

;; (eval-when-compile
;;  (require 'use-package))

;; (setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/elpa/s-20220902.1511/")
(add-to-list 'load-path "~/.emacs.d/elpa/anaphora-20240120.1744/")
(add-to-list 'load-path "~/.emacs.d/elpa/lv-20200507.1518/")

(use-package anaphora :ensure t)

(use-package bind-key :ensure t)

(use-package dash :ensure t)

(use-package hydra :ensure t)

(use-package s :ensure t)

(use-package lv :ensure t)

(use-package catppuccin-theme
  :if window-system
  :ensure t
  :config
  (setq catppuccin-flavor 'latte)
  (load-theme 'catppuccin :no-confirm))

(use-package company
  :ensure t
  :commands company-mode
  :bind (("C-c SPC" . company-complete)
         :map company-active-map
         ("C-t" . company-select-previous-or-abort)
         ("C-p" . company-select-previous-or-abort)
         ("C-n" . company-select-next-or-abort)
         ("C-c h" . company-show-doc-buffer)
         ("C-a" . company-select-first)
         ("C-e" . company-select-last)
         ("C-h" . delete-backward-char))
  :config
  (with-eval-after-load 'company-semantic
    (add-to-list 'company-semantic-modes 'rescript2-mode))
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case 'keep-prefix)
  (setq company-dabbrev-code-ignore-case nil))

(use-package lsp-ui
  :defer t
  :config
  (with-eval-after-load 'lsp-ui-doc
    (assoc-delete-all 'font lsp-ui-doc-frame-parameters)
    (push (cons 'font (my/get-font 18)) lsp-ui-doc-frame-parameters)))

(use-package org-mode
  :defer t
  :bind (:map org-mode-map
              ("S-RET" . backward-word)
              ("C-<tab>" . nil)
              ("S-<left>" . nil)
              ("S-<right>" . nil)))

(use-package org-roam :defer t)

(load "/home/carl/git/environment/elisp/utils")
(load "/home/carl/git/environment/elisp/keybindings")

(load "/home/carl/git/environment/elisp/formatting")
;; (load "/home/carl/git/environment/elisp/japanese")
(load "/home/carl/git/environment/elisp/navigation")
(load "/home/carl/git/environment/elisp/settings")

(load "/home/carl/git/environment/elisp/config/avy")
;; (load "/home/carl/git/environment/elisp/config/common-lisp")
;; (load "/home/carl/git/environment/elisp/config/elixir")
;; (load "/home/carl/git/environment/elisp/config/emojify")
(load "/home/carl/git/environment/elisp/config/font")
(load "/home/carl/git/environment/elisp/config/grep")
(load "/home/carl/git/environment/elisp/config/helm")
(load "/home/carl/git/environment/elisp/config/javascript")
;; (load "/home/carl/git/environment/elisp/config/nix")
;; (load "/home/carl/git/environment/elisp/config/ocaml")
;; (load "/home/carl/git/environment/elisp/config/org")
(load "/home/carl/git/environment/elisp/config/projectile")
;; (load "/home/carl/git/environment/elisp/config/prolog")
;; (load "/home/carl/git/environment/elisp/config/quail")
(load "/home/carl/git/environment/elisp/config/rescript")
(load "/home/carl/git/environment/elisp/config/rescript2")
;; (load "/home/carl/git/environment/elisp/config/rust")
;; (load "/home/carl/git/environment/elisp/config/scheme")
(load "/home/carl/git/environment/elisp/config/vterm")
;; (load "/home/carl/git/environment/elisp/config/zig")

(when (file-exists-p (expand-file-name "~/scratch.el"))
  (with-temp-buffer
    (find-file "~/scratch.el")
    (eval-buffer)
    (kill-buffer)))

(put 'downcase-region 'disabled nil)
