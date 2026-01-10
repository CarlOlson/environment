;;; -*- lexical-binding: t; -*-

(use-package projectile
  :demand t
  :ensure t
  :bind (
         :map projectile-mode-map
         ("C-c C-f" . helm-projectile-find-file)
         ("C-c C-t" . projectile-toggle-between-implementation-and-test)
         ("C-c <up>" . projectile-toggle-between-implementation-and-test)
         ("C-c p c" . projectile-compile-project)
         ("C-c p t" . projectile-test-project)
         ("C-c p r" . projectile-rgrep)
         ("C-c p g" . projectile-grep)
         ("C-c p p" . projectile-commander)
         )
  :config
  (assq-delete-all 'npm projectile-project-types)
  (assq-delete-all 'yarn projectile-project-types))

(use-package helm-projectile :ensure t)
