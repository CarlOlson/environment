;;; -*- lexical-binding: t; -*-

(with-system sm
  (require 'golden-ratio)
  (add-to-list 'golden-ratio-extra-commands 'select-next-window)
  (add-to-list 'golden-ratio-extra-commands 'quit-window)
  (add-to-list 'golden-ratio-extra-commands 'projectile-test-project)
  (golden-ratio-mode 1)
  (remove-lighter 'golden-ratio-mode))
