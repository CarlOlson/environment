;;; -*- lexical-binding: t; -*-

(use-package prettier-mode
  :commands prettier-mode)

(use-package tide
  :commands tide-mode)

(use-package typescript-mode
  :commands typescript-mode
  :config
  (add-hook 'typescript-mode-hook #'my/typescript-mode-hook))

(use-package web-mode
  :commands (web-mode jsx-web-mode snap-web-mode css-web-mode)
  :mode
  (("\\.\\(?:cjs\\|jsx?\\|mjs\\)$" . jsx-web-mode)
   ("\\.json$" . json-web-mode)
   ("\\.snap$" . snap-web-mode)
   ("\\.css$" . css-web-mode)
   ("\\.eex?$" . eex-web-mode)
   ("\\.leex?$" . leex-web-mode))
  :config
  (define-key web-mode-map (kbd "C-c C-f") nil)

  (define-derived-mode jsx-web-mode web-mode "jsx-Web"
    "Version of web-mode just for js and jsx files."
    (setq-local web-mode-markup-indent-offset 2)
    (setq-local web-mode-code-indent-offset 2)
    (setq-local web-mode-enable-auto-quoting nil)
    (web-mode-set-content-type "jsx")
    (prettier-mode +1))

  (define-derived-mode json-web-mode web-mode "json-Web"
    "Version of web-mode just for js and jsx files."
    (setq-local web-mode-markup-indent-offset 2)
    (setq-local web-mode-code-indent-offset 2)
    (setq-local web-mode-enable-auto-quoting nil)
    (web-mode-set-content-type "json")
    (prettier-mode +1))

  (define-derived-mode snap-web-mode jsx-web-mode "snap-Web"
    "Version of web-mode just Jest snap files."
    (setq-local before-save-hook nil)
    (prettier-mode -1))

  (define-derived-mode css-web-mode web-mode "css-Web"
    "Version of web-mode just for CSS files."
    (setq-local web-mode-markup-indent-offset 2)
    (web-mode-set-content-type "css")
    (prettier-mode +1))

  (define-derived-mode eex-web-mode web-mode "eex-Web"
    "Version of web-mode just for eex files."
    (web-mode-set-engine "elixir"))

  (define-derived-mode leex-web-mode eex-web-mode "leex-Web"
    "Version of web-mode just for leex files."))

(defun my/typescript-mode-hook ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (eldoc-mode +1)
  (prettier-mode +1)
  (setq-local flycheck-check-syntax-automatically '(save mode-enabled)))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(jsx-web-mode . "javascript"))
  (add-to-list 'lsp-language-id-configuration '(snap-web-mode . "javascript"))
  (add-to-list 'lsp-language-id-configuration '(json-web-mode . "json")))
