;;; -*- lexical-binding: t; -*-

(eval-after-load 'projectile-mode
  '(progn
     (define-key projectile-mode-map (kbd "C-c C-f") 'helm-projectile-find-file-dwim)
     (define-key projectile-mode-map (kbd "C-c C-t") 'projectile-toggle-between-implementation-and-test)
     (define-key projectile-mode-map (kbd "C-c <up>") 'projectile-toggle-between-implementation-and-test)
     (define-key projectile-mode-map (kbd "C-c t") 'projectile-test-project)
     (define-key projectile-mode-map (kbd "C-c r") 'rgrep)
     (define-key projectile-mode-map (kbd "C-c g") 'helm-projectile-grep)))
