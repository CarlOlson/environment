;;; -*- lexical-binding: t; -*-

(defun my/grep-mode-hook ()
  (interactive)
  (setq-local truncate-lines t))

(add-hook 'grep-mode-hook 'my/grep-mode-hook)
