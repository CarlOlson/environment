;;; -*- lexical-binding: t; -*-

(use-package zig-mode
  :after (lsp-mode)
  :commands zig-mode
  :config
  (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "/home/carl/zls/zls")
    :major-modes '(zig-mode)
    :server-id 'zls))
  (setq lsp-zig-zls-executable "/home/carl/zls/zls")
  (add-hook 'zig-mode-hook 'lsp))
