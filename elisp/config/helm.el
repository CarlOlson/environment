;;; -*- lexical-binding: t; -*-

(require 'helm)
(require 'helm-config)
(helm-mode 1)
(remove-lighter 'helm-mode)

(setq helm-M-x-always-save-history t
      helm-rg-default-directory 'git-root)

(add-to-list 'helm-boring-buffer-regexp-list (rx "*ansi-term*"))
(add-to-list 'helm-boring-buffer-regexp-list (rx "*Buffer List*"))
(add-to-list 'helm-boring-buffer-regexp-list (rx "magit-"))

(add-to-list 'helm-find-files-actions '("Insert File Name" . insert) t)
(add-to-list 'helm-find-files-actions '("File Name as Kill" . kill-new) t)

(add-to-list 'helm-type-buffer-actions '("Insert Buffer Name" . insert) t)
(add-to-list 'helm-type-buffer-actions '("Buffer Name as Kill" . kill-new) t)

(define-key helm-generic-files-map (kbd "C-k") 'my/helm-ff-run-copy-as-kill)

(defun my/helm-ff-run-copy-as-kill ()
  "Run switch to other frame action from `helm-source-find-files'."
  (interactive)
  (with-helm-alive-p
    (helm-exit-and-execute-action 'kill-new)))
