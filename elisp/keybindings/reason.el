;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'reason-mode
  (define-key reason-mode-map (kbd "M-q") 'reason-fill-paragraph))

(define-key rescript-mode-map (kbd "C-c <tab>") 'bsc-format-buffer)
