;;; -*- lexical-binding: t; -*-

(setq custom-file "~/git/environment/custom.el")
(load custom-file)

(package-initialize)

(setq package-archives
      `(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(let ((get-packages (burn-on-call 'package-refresh-contents)))
  (dolist (package package-selected-packages)
    (unless (package-installed-p package)
      (unless (assoc package package-archive-contents)
        (funcall get-packages))
      (package-install package))))
