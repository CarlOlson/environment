;;; -*- lexical-binding: t; -*-

(setq prolog-system 'swi
      prolog-program-name "/usr/bin/swipl")
(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . mercury-mode))
