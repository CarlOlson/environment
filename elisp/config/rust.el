;;; -*- lexical-binding: t; -*-

(defun my/rust-mode-hook ()
  (interactive)
  (setq-local company-idle-delay 0.2
              company-minimum-prefix-length 1
              lsp-signature-render-documentation nil))

(with-eval-after-load "rust-mode"
  (define-key rust-mode-map (kbd "<tab>") 'company-indent-or-complete-common)
  (add-hook 'rust-mode-hook 'my/rust-mode-hook)
  (add-hook 'rust-mode-hook 'yas-minor-mode-on))
