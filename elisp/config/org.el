;;; -*- lexical-binding: t; -*-

(eval-after-load 'org-babel
  (setq org-babel-default-header-args
        (cons '(:tangle . "yes")
	      (assq-delete-all :tangle org-babel-default-header-args))))
