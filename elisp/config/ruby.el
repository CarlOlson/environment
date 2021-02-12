;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'ruby-mode
  (require 'rspec-mode)
  (setq rspec-use-rvm t
        compilation-scroll-output nil))
