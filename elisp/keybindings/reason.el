;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'reason-mode
  (define-key reason-mode-map (kbd "M-q") 'reason-fill-paragraph))
