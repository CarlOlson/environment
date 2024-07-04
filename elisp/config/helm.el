;;; -*- lexical-binding: t; -*-

(use-package helm
  :ensure t
  :bind (
         :map helm-map
         ("TAB" . helm-execute-persistent-action)
         ("C-z" . helm-select-action)
         ("C-t" . helm-previous-line)
         ("C-h" . delete-backward-char)
         :map helm-generic-files-map
         ("C-k" . my/helm-ff-run-copy-as-kill)
         :map helm-find-files-map
         ("C-b" . backward-char)
         ("<left>" . backward-char)
         :map helm-read-file-map
         ("<left>" . left-char)
         ("<right>" . right-char))
  :config
  (remove-lighter 'helm-mode)

  (add-to-list 'helm-boring-buffer-regexp-list (rx "*ansi-term*"))
  (add-to-list 'helm-boring-buffer-regexp-list (rx "*Buffer List*"))
  (add-to-list 'helm-boring-buffer-regexp-list (rx "magit-"))

  (add-to-list 'helm-find-files-actions '("Find File Literally" . find-file-literally) t)

  (add-to-list 'helm-find-files-actions '("Insert File Name" . insert) t)
  (add-to-list 'helm-find-files-actions '("File Name as Kill" . kill-new) t)

  (add-to-list 'helm-type-buffer-actions '("Insert Buffer Name" . insert) t)
  (add-to-list 'helm-type-buffer-actions '("Buffer Name as Kill" . kill-new) t))

(with-eval-after-load "helm-utils"
  (defun helm-open-file-with-default-tool (file)
    "Open FILE with the default tool on this platform."
    (let (process-connection-type)
      (if (eq system-type 'windows-nt)
          (helm-w32-shell-execute-open-file file)
        (start-process "helm-open-file-with-default-tool"
                       nil
                       (cond ((string-match "-[Mm]icrosoft" operating-system-release)
                              "wslview")
                             ((eq system-type 'gnu/linux)
                              "xdg-open")
                             ((or (eq system-type 'darwin) ;; Mac OS X
                                  (eq system-type 'macos)) ;; Mac OS 9
                              "open"))
                       (file-relative-name file default-directory))))))

(defun my/helm-ff-run-copy-as-kill ()
  "Run switch to other frame action from `helm-source-find-files'."
  (interactive)
  (with-helm-alive-p
    (helm-exit-and-execute-action 'kill-new)))
