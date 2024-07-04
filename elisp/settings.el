;;; -*- lexical-binding: t; -*-

(when (display-graphic-p)
  (server-start nil t))

(with-system linux
  (add-to-list 'exec-path "/home/carl/.local/bin")
  (add-to-list 'exec-path "/home/carl/.asdf/shims"))

(add-to-list 'load-path "~/git/environment/elisp/vendor")
(add-to-list 'load-path "~/git/environment/elisp/modes")

(add-to-list 'auto-mode-alist `(,(rx "/.env" (or eol ".")) . sh-mode))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'after-init-hook 'session-initialize)
