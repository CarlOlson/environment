;;; -*- lexical-binding: t; -*-

(use-package emojify
  :ensure t
  :bind (("C-c e" . emojify-insert-emoji))
  :config
  (when (member "Segoe UI Emoji" (font-family-list))
    (set-fontset-font
     t 'symbol (font-spec :family "Segoe UI Emoji") nil 'prepend))
  (setq emojify-display-style 'unicode
        emojify-emoji-styles '(unicode)))
