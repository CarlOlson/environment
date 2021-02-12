;;; -*- lexical-binding: t; -*-

(eval-after-load 'org-mode
  '(progn
     (define-key org-mode-map (kbd "C-<tab>") nil)
     (define-key org-mode-map (kbd "S-<left>") nil)
     (define-key org-mode-map (kbd "S-<right>") nil)))
