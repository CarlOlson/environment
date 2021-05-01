;;; -*- lexical-binding: t; -*-

(projectile-register-project-type
 'yarn '("yarn.lock")
 :test "yarn test"
 :run "yarn start"
 :related-files-fn (list
                    (projectile-related-files-fn-test-with-suffix "re" "_Test")
                    (projectile-related-files-fn-test-with-suffix "rei" "_Test")
                    (projectile-related-files-fn-test-with-suffix "js" ".spec")))

(define-derived-mode jsx-web-mode web-mode "jsx-Web"
  "Version of web-mode just for js and jsx files."
  (setq-local web-mode-markup-indent-offset 2)
  (setq-local web-mode-code-indent-offset 2)
  (setq-local web-mode-enable-auto-quoting nil)
  (web-mode-set-content-type "jsx"))

(define-derived-mode json-web-mode web-mode "json-Web"
  "Version of web-mode just for js and jsx files."
  (setq-local web-mode-markup-indent-offset 2)
  (setq-local web-mode-code-indent-offset 2)
  (setq-local web-mode-enable-auto-quoting nil)
  (web-mode-set-content-type "json"))

(add-to-list 'auto-mode-alist '("\\.jsx?$" . jsx-web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-web-mode))

(defun my/typescript-mode-hook ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (eldoc-mode +1)
  (setq-local flycheck-check-syntax-automatically '(save mode-enabled))
  (add-hook 'before-save-hook 'tide-format-before-save nil t))

(add-hook 'typescript-mode-hook #'my/typescript-mode-hook)
