;;; -*- lexical-binding: t; -*-

(require 'anaphora)

(defconst nix-shell-regexp
  (rx (*? any) "nix-shell"
      (*? whitespace) "\n"
      (*? any) "nix-shell"
      (*? any) "-i" (+ whitespace)
      (group (+ alphanumeric))))

(defconst nix-shell-alist
  `(("ruby"   . ruby-mode)
    ("python" . python-mode)
    ("bash"   . shell-script-mode)
    ("zsh"    . shell-script-mode)
    ("fish"   . fish-mode)))

(defun set-nix-shell-file-mode ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (looking-at nix-shell-regexp)
    (anaphoric-and
     (match-string-no-properties 1)
     (assoc-default it nix-shell-alist)
     (funcall it))))

(add-hook 'hack-local-variables-hook 'set-nix-shell-file-mode)
