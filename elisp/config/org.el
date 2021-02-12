;;; -*- lexical-binding: t; -*-

(require 'org)

(setq org-babel-default-header-args
      (cons '(:tangle . "yes")
	    (assq-delete-all :tangle org-babel-default-header-args)))
