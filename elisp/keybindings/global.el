;;; -*- lexical-binding: t; -*-

;; Disable selection via the mouse!
(global-set-key (kbd "<down-mouse-1>") nil)
(global-set-key (kbd "<mouse-1>") nil)

;; And everything else...
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<tab>") 'select-next-window)
(global-set-key (kbd "C-c <tab>") 'reindent-buffer)
(global-set-key (kbd "C-c SPC") 'company-complete)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-o") 'save-buffer)
(global-set-key (kbd "C-t") 'previous-line)
(global-set-key (kbd "C-x h") 'help-command)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-c") 'upcase-previous-word)
(global-set-key (kbd "M-t") 'vterm-navigate)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x o") 'helm-occur)
(global-set-key (kbd "M-u") 'helm-M-x)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "<help> a") 'helm-apropos)

(global-set-key (kbd "C-c f") 'projectile-find-file-dwim)
(global-set-key (kbd "C-c C-f") 'projectile-find-file)

(global-set-key (kbd "C-S-m") 'backward-word)
(global-set-key (kbd "C-S-g") 'forward-word)
(global-set-key (kbd "C-S-d") 'delete-forward-word)
(global-set-key (kbd "C-S-h") 'delete-backward-word)

(global-set-key (kbd "<S-left>") 'backward-word)
(global-set-key (kbd "<S-right>") 'forward-word)
(global-set-key (kbd "<S-delete>") 'delete-forward-word)
(global-set-key (kbd "<S-backspace>") 'delete-backward-word)

(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-'") 'avy-goto-char-2)
(global-set-key (kbd "M-f") 'avy-find-file)

(global-set-key (kbd "C-.") 'mc/mark-next-like-this-word)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this-word)
(global-set-key (kbd "C-c C-.") 'mc/mark-all-words-like-this)
(global-set-key (kbd "S-<mouse-1>") 'mc/add-cursor-on-click)

;; Fix some annoyances with internal keyboards...
(defun my/keyboard-translations (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (with-system not-tty
      (keyboard-translate ?\C-u ?\C-x)
      (keyboard-translate ?\C-i ?\C-g)
      (keyboard-translate ?\C-g ?\C-f))
    (with-system tty
      (kill-emacs))))

(my/keyboard-translations)
(add-hook 'after-make-frame-functions 'my/keyboard-translations)
(add-hook 'server-visit-hook 'my/keyboard-translations)

(global-set-key (kbd "s-u") 'universal-argument)
(define-key universal-argument-map (kbd "s-u") 'universal-argument-more)
