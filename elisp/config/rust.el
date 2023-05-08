;;; -*- lexical-binding: t; -*-

(use-package rustic
  :after (company yasnippet lsp-mode r)
  :ensure t
  :commands rustic-mode
  :mode (("\\.rs$" . rustic-mode))
  :bind (
         :map rustic-mode-map
         ("<tab>" . company-indent-or-complete-common)
         ("RET" . newline-and-indent)
         )
  :config
  (add-hook 'rustic-mode-map 'my/rust-mode-hook)
  (add-hook 'rustic-mode-map 'yas-minor-mode))

(defun my/rust-mode-hook ()
  (interactive)
  (setq-local company-idle-delay 0.2
              company-minimum-prefix-length 2
              lsp-signature-render-documentation nil))
