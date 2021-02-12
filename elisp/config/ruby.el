;;; -*- lexical-binding: t; -*-

(eval-after-load 'ruby-mode
  '(progn
     (require 'rspec-mode)
     (setq rspec-use-rvm t
           compilation-scroll-output nil)))
