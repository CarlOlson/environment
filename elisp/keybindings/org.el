;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'org-mode
  (define-key org-mode-map (kbd "C-<tab>") nil)
  (define-key org-mode-map (kbd "S-<left>") nil)
  (define-key org-mode-map (kbd "S-<right>") nil))
