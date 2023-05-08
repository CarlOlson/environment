;;; -*- lexical-binding: t; -*-

(use-package merlin
  :commands merlin-mode
  :config
  (setq merlin-command "/home/carl/.opam/default/bin/ocamlmerlin"))

(use-package tuareg
  :after (merlin)
  :commands tuareg-mode
  :config
  (add-hook 'tuareg-mode-hook 'merlin-mode t))
