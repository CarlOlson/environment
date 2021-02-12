;;; -*- lexical-binding: t; -*-

(eval-after-load 'emacs-lisp-mode
  '(progn
     (define-key emacs-lisp-mode-map (kbd "C-c C-l") 'eval-buffer)
     (define-key emacs-lisp-mode-map (kbd "C-c C-r") 'eval-region)))
