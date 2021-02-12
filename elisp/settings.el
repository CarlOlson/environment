;;; -*- lexical-binding: t; -*-

(setq inhibit-startup-screen   t
      initial-major-mode       'emacs-lisp-mode
      indent-tabs-mode         nil
      make-backup-files        nil
      auto-save-default        nil
      create-lockfiles         nil
      compilation-read-command nil
      electric-indent-inhibit  t)

;; Improve LSP mode performance
(setq gc-cons-threshold (mb-to-bytes 256)
      read-process-output-max (mb-to-bytes 4))

(set-default 'indent-tabs-mode        nil)
(set-default 'electric-indent-inhibit t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(menu-bar-mode -1)
(tool-bar-mode -1)

(show-paren-mode t)

(when (display-graphic-p)
  (server-start nil t))

(with-temp-buffer
  (find-file "~/scratch.el")
  (eval-buffer)
  (kill-buffer))

(add-to-list 'load-path "~/git/environment/elisp/vendor")

(with-system linux
  (add-to-list 'exec-path "/home/carl/.local/bin"))

(require 'session)
(add-hook 'after-init-hook 'session-initialize)
