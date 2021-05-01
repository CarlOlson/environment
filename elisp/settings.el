;;; -*- lexical-binding: t; -*-

(setq electric-indent-inhibit t)

;; Improve LSP mode performance
(setq
 ;; 800 default
 max-lisp-eval-depth 800
 ;; 1600 default
 max-specpdl-size 1600
 ;; 800kb default, 100mb spacemacs
 gc-cons-threshold (mb-to-bytes 100)
 ;; 4k default, 1mb+ lsp recommendation
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
  (add-to-list 'exec-path "/home/carl/.local/bin")
  (add-to-list 'exec-path "/home/carl/.asdf/shims"))

(add-hook 'after-init-hook 'session-initialize)
