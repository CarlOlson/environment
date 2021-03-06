;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'helm-mode
  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (define-key helm-map (kbd "C-t") 'helm-previous-line)
  (define-key helm-map (kbd "C-h") 'delete-backward-char)

  (define-key helm-generic-files-map (kbd "C-k") 'my/helm-ff-run-copy-as-kill)

  (define-key helm-find-files-map (kbd "C-b") 'backward-char)
  (define-key helm-find-files-map (kbd "<left>") 'backward-char))
