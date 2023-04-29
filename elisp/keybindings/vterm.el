;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "M-u") nil)
  (define-key vterm-mode-map (kbd "M-x") nil)
  (define-key vterm-mode-map (kbd "M-t") nil)
  (define-key vterm-mode-map (kbd "M-f") 'avy-find-file)

  (define-key vterm-mode-map (kbd "C-h") 'self-insert-command)
  (define-key vterm-mode-map (kbd "C-k") 'vterm-kill)
  (define-key vterm-mode-map (kbd "C-y") 'vterm-yank)

  (define-key vterm-copy-mode-map (kbd "C-k") 'vterm-copy-kill-line)
  (define-key vterm-copy-mode-map [remap kill-region] 'vterm-copy-mode-done)

  (define-key vterm-mode-map (kbd "C-SPC") 'vterm-copy-mode)
  (define-key vterm-copy-mode-map (kbd "q") 'vterm-copy-mode)

  (define-key vterm-mode-map (kbd "S-RET") 'vterm-send-M-b)
  (define-key vterm-mode-map (kbd "C-S-g") 'vterm-send-M-f)

  (define-key vterm-mode-map (kbd "<S-right>") 'self-insert-command)
  (define-key vterm-mode-map (kbd "<S-left>") 'self-insert-command)
  (define-key vterm-mode-map (kbd "<S-backspace>") 'vterm-send-C-w)
  (define-key vterm-mode-map (kbd "<S-delete>") 'vterm-send-M-d)
  (define-key vterm-mode-map (kbd "C-S-h") 'vterm-send-C-w)
  (define-key vterm-mode-map (kbd "C-S-d") 'vterm-send-M-d))

(defhydra hydra-vterm (global-map "M-t" :timeout 5 :hint nil)
  "vterm"
  ("n" multi-vterm-next "next")
  ("t" multi-vterm-prev "previous")
  ("p" multi-vterm-project-same-window "create in project")
  ("a" multi-vterm-toggle-all "show all")
  ("r" vterm-reset-cursor-point "reset cursor")

  ("c" multi-vterm "create" :exit t)
  ("k" kill-this-buffer-quick "kill" :exit t)
  ("m" magit "magit" :exit t)
  ("M-t" vterm-toggle "toggle" :exit t)
  ("g" ignore "cancel" :exit t)
  ("q" vterm-hide-many "quit" :exit t))
