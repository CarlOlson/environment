;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'rescript-mode
  (define-key rescript-mode-map (kbd "M-q") 'rescript-fill-paragraph)
  (define-key rescript-mode-map (kbd "C-c p s") 'projectile-toggle-between-implementation-and-test)
  (define-key rescript-mode-map (kbd "C-c p t") 'projectile-test-project)
  (define-key rescript-mode-map (kbd "C-c p c") 'projectile-compile-project))

(with-eval-after-load 'reason-mode
  (define-key reason-mode-map (kbd "C-c <tab>") 'bsrefmt-file))
