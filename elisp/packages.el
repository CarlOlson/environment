;;; -*- lexical-binding: t; -*-

(setq custom-file "~/git/environment/custom.el")
(load custom-file)

(package-initialize)

(let ((get-packages (burn-on-call 'package-refresh-contents)))
  (dolist (package package-selected-packages)
    (unless (package-installed-p package)
      (unless (assoc package package-archive-contents)
        (funcall get-packages))
      (package-install package))))
