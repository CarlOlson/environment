;;; -*- lexical-binding: t; -*-

(load "/home/carl/git/environment/elisp/utils")
(load "/home/carl/git/environment/elisp/keybindings")

(eval-and-compile
  (package-initialize))

(eval-when-compile
  (require 'use-package))

(use-package anaphora :ensure t)
(use-package bind-key :ensure t)
(use-package dash :ensure t)
(use-package hydra :ensure t)
(use-package s :ensure t)
(use-package solarized-theme :if window-system :ensure t)

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
         ("C-h" . delete-backward-char)))

(load "/home/carl/git/environment/elisp/formatting")
(load "/home/carl/git/environment/elisp/japanese")
(load "/home/carl/git/environment/elisp/navigation")
(load "/home/carl/git/environment/elisp/settings")

(load "/home/carl/git/environment/elisp/config/avy")
(load "/home/carl/git/environment/elisp/config/common-lisp")
(load "/home/carl/git/environment/elisp/config/elixir")
(load "/home/carl/git/environment/elisp/config/emojify")
(load "/home/carl/git/environment/elisp/config/font")
(load "/home/carl/git/environment/elisp/config/grep")
(load "/home/carl/git/environment/elisp/config/helm")
(load "/home/carl/git/environment/elisp/config/javascript")
(load "/home/carl/git/environment/elisp/config/nix")
(load "/home/carl/git/environment/elisp/config/ocaml")
(load "/home/carl/git/environment/elisp/config/org")
(load "/home/carl/git/environment/elisp/config/projectile")
(load "/home/carl/git/environment/elisp/config/prolog")
(load "/home/carl/git/environment/elisp/config/quail")
(load "/home/carl/git/environment/elisp/config/rescript")
(load "/home/carl/git/environment/elisp/config/rust")
(load "/home/carl/git/environment/elisp/config/scheme")
(load "/home/carl/git/environment/elisp/config/vterm")
(load "/home/carl/git/environment/elisp/config/zig")

(use-package lsp-ui
  :defer t
  :config
  (with-eval-after-load 'lsp-ui-doc
    (assoc-delete-all 'font lsp-ui-doc-frame-parameters)
    (push (cons 'font (my/get-font 34)) lsp-ui-doc-frame-parameters)))

(use-package org-mode
  :bind (:map org-mode-map
              ("S-RET" . backward-word)
              ("C-<tab>" . nil)
              ("S-<left>" . nil)
              ("S-<right>" . nil)))
(use-package org-roam)

(when (file-exists-p (expand-file-name "~/scratch.el"))
  (with-temp-buffer
    (find-file "~/scratch.el")
    (eval-buffer)
    (kill-buffer)))
