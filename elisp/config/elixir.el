;;; -*- lexical-binding: t; -*-

(projectile-register-project-type 'elixir '("mix.exs")
                                  :compile "mix deps.get"
                                  :test "mix test --no-color"
                                  :run "mix app.start"
                                  :src-dir "lib"
                                  :test-dir "test"
                                  :test-suffix "_test"
                                  :related-files-fn 'phx/related-files)

(defun phx/related-files (path)
  (let* ((filename (file-name-nondirectory path))
         (files (projectile-project-files (projectile-project-root))))
    (when (string-match (rx (group (+ alpha)) "_") filename)
      (let ((prefix (match-string 1 filename)))
        (list :templates (cl-remove-if-not
                          (lambda (file)
                            (string-match (concat "templates/" prefix) file))
                          files))))))

(define-derived-mode eex-web-mode web-mode "eex-Web"
  "Version of web-mode just for eex files."
  (web-mode-set-engine "elixir"))

(define-derived-mode leex-web-mode eex-web-mode "leex-Web"
  "Version of web-mode just for leex files.")

(add-hook 'elixir-mode-hook 'company-mode)
(setenv "HEX_HTTP_CONCURRENCY" "1")
(setenv "HEX_HTTP_TIMEOUT"     "60")

(add-to-list 'auto-mode-alist '("\\.eex?$" . eex-web-mode))
(add-to-list 'auto-mode-alist '("\\.leex?$" . leex-web-mode))

;; Match test errors correctly in compilation-mode
(eval-after-load "compile"
  '(progn
     (add-to-list
      'compilation-error-regexp-alist-alist
      (list 'mix
            (rx " " (group (*? (not whitespace)) "ex" (? "s")) ":" (group (+ digit)) ":")
            1 2 nil nil 1))
     (add-to-list 'compilation-error-regexp-alist 'mix)))

;; Properly wrap exdoc strings
(defun ex/hook ()
  (setq-local paragraph-start
              (rx (or (group (* whitespace) num "." (* any) eol)
                      (group (* whitespace) eol))))
  (setq-local paragraph-separate
              (rx (or (group (* any) "\"\"\"" (* whitespace) eol)
                      (group (* whitespace) eol)))))

(add-hook 'elixir-mode-hook 'ex/hook)
