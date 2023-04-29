;;; -*- lexical-binding: t; -*-

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

(add-to-list 'auto-mode-alist `(,(rx "." (or "js" "jsx" "cjs" "mjs") eol) . jsx-web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-web-mode))
(add-to-list 'auto-mode-alist '("\\.snap$" . snap-web-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-web-mode))

(defun my/typescript-mode-hook ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (eldoc-mode +1)
  (prettier-mode +1)
  (setq-local flycheck-check-syntax-automatically '(save mode-enabled)))

(add-hook 'typescript-mode-hook #'my/typescript-mode-hook)

(add-hook 'css-mode #'prettier-mode)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(jsx-web-mode . "javascript"))
  (add-to-list 'lsp-language-id-configuration '(snap-web-mode . "javascript"))
  (add-to-list 'lsp-language-id-configuration '(json-web-mode . "json")))

(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-c C-f") nil))
