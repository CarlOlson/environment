;;; -*- lexical-binding: t; -*-

(eval-after-load 'vterm
  '(progn
     (define-key vterm-mode-map (kbd "M-u") nil)
     (define-key vterm-mode-map (kbd "M-x") nil)
     (define-key vterm-mode-map (kbd "M-t") nil)
     (define-key vterm-mode-map (kbd "C-h") 'self-insert-command)

     (define-key vterm-mode-map (kbd "C-k") 'term-kill)
     (define-key vterm-mode-map (kbd "C-y") 'vterm-yank)

     (define-key vterm-mode-map (kbd "C-SPC") 'vterm-copy-mode)
     (define-key vterm-copy-mode-map (kbd "q") 'vterm-copy-mode)

     (define-key vterm-mode-map (kbd "<S-right>") 'self-insert-command)
     (define-key vterm-mode-map (kbd "<S-left>") 'self-insert-command)
     (define-key vterm-mode-map (kbd "<S-backspace>") 'vterm-send-C-w)
     (define-key vterm-mode-map (kbd "<S-delete>") 'vterm-send-M-d)))
