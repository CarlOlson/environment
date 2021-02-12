;;; -*- lexical-binding: t; -*-

(require 'projectile)
(require 'helm-projectile)

(setq projectile-project-types
      (assq-delete-all 'npm projectile-project-types))

(projectile-register-project-type 'generic '("script")
                                  :compile "./script/update"
                                  :test "./script/test"
                                  :run "./script/server"
                                  :src-dir "lib"
                                  :test-dir "test"
                                  :test-suffix "_test")

(projectile-register-project-type 'dune '("dune" "dune-project")
                                  :compile "dune build"
                                  :test "dune runtest"
                                  :run "dune exec ./main.exe"
                                  :src-dir ".")
