;;; -*- no-byte-compile: t; lexical-binding: t; -*-

;; Disable selection via the mouse!
(global-set-key (kbd "<down-mouse-1>") nil)
(global-set-key (kbd "<mouse-1>") nil)

;; And everything else...
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<tab>") 'select-next-window)
(global-set-key (kbd "C-c <tab>") 'reindent-buffer)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-o") 'save-buffer)
(global-set-key (kbd "C-t") 'previous-line)
(global-set-key (kbd "C-x h") 'help-command)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-c") 'upcase-previous-word)
(global-set-key (kbd "C-x o") 'occur)

(global-set-key (kbd "C-S-m") 'backward-word)
(global-set-key (kbd "C-S-g") 'forward-word)
(global-set-key (kbd "C-S-d") 'delete-forward-word)
(global-set-key (kbd "C-S-h") 'delete-backward-word)

(global-set-key (kbd "<S-left>") 'backward-word)
(global-set-key (kbd "<S-right>") 'forward-word)
(global-set-key (kbd "<S-delete>") 'delete-forward-word)
(global-set-key (kbd "<S-backspace>") 'delete-backward-word)

(global-set-key (kbd "M-u") 'execute-extended-command)

(global-set-key (kbd "s-u") 'universal-argument)
(define-key universal-argument-map (kbd "s-u") 'universal-argument-more)

(defun is-tty ()
  (not (seq-empty-p (tty-type))))

;; Fix some annoyances with internal keyboards...
(defun my/keyboard-translations (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (unless (is-tty)
      (keyboard-translate ?\C-u ?\C-x)
      (keyboard-translate ?\C-i ?\C-g)
      (keyboard-translate ?\C-g ?\C-f))))

(my/keyboard-translations)
(add-hook 'after-make-frame-functions 'my/keyboard-translations)
