;;; -*- lexical-binding: t; -*-

(let ((file (expand-file-name "~/.roswell/helper.el")))
  (when (file-exists-p file)
    (load file)))

(with-eval-after-load 'slime
  (defvar inferior-lisp-program)
  (setq inferior-lisp-program "ros -Q run")
  (slime-setup '(slime-company slime-repl-ansi-color slime-asdf)))
