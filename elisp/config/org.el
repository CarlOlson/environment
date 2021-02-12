;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'ob
  (setq org-babel-default-header-args
        (cons '(:tangle . "yes")
	      (assq-delete-all :tangle org-babel-default-header-args))))
