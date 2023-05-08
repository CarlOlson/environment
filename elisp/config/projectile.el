;;; -*- lexical-binding: t; -*-

(use-package projectile
  :demand t
  :ensure t
  :bind (
         :map projectile-mode-map
         ("C-c C-f" . helm-projectile-find-file-dwim)
         ("C-c C-t" . projectile-toggle-between-implementation-and-test)
         ("C-c <up>" . projectile-toggle-between-implementation-and-test)
         ("C-c t" . projectile-test-project)
         ("C-c r" . rgrep)
         ("C-c g" . helm-projectile-grep)
         )
  :config
  (setq projectile-project-types
        (assq-delete-all 'npm projectile-project-types)))

(use-package helm-projectile
  :demand t
  :ensure t)
