;;; -*- lexical-binding: t; -*-

(require 'helm)
(require 'helm-config)

(defun my/helm-ff-run-copy-as-kill ()
  "Run switch to other frame action from `helm-source-find-files'."
  (interactive)
  (with-helm-alive-p
    (helm-exit-and-execute-action 'kill-new)))

(remove-lighter 'helm-mode)

(add-to-list 'helm-boring-buffer-regexp-list (rx "*ansi-term*"))
(add-to-list 'helm-boring-buffer-regexp-list (rx "*Buffer List*"))
(add-to-list 'helm-boring-buffer-regexp-list (rx "magit-"))

(add-to-list 'helm-find-files-actions '("Insert File Name" . insert) t)
(add-to-list 'helm-find-files-actions '("File Name as Kill" . kill-new) t)

(add-to-list 'helm-type-buffer-actions '("Insert Buffer Name" . insert) t)
(add-to-list 'helm-type-buffer-actions '("Buffer Name as Kill" . kill-new) t)
