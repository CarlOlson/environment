;;; -*- lexical-binding: t; -*-

(with-eval-after-load "company"
  (define-key company-active-map (kbd "C-t") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-c h") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "C-a") 'company-select-first)
  (define-key company-active-map (kbd "C-e") 'company-select-last)
  (define-key company-active-map (kbd "C-h") 'delete-backward-char))
