;;; -*- lexical-binding: t; -*-

(eval-after-load 'company-mode
  '(progn
     (define-key company-active-map (kbd "C-t") 'company-select-previous-or-abort)
     (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
     (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)))
