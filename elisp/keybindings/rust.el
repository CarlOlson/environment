;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'rust-mode
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common))