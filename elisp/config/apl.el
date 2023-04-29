;;; -*- lexical-binding: t; -*-

(require 'rx)

(defvar apl-builtin-rx
  (regexp-opt
   (split-string "⍞⎕∇-×÷⌈⌊*!|⍟○⌹⊥⊤?~∧∨⍲⍱<>≤≥=≠≡≢⍴,⍪⌽⊖⍉↑↓⊂⊆≡∊⌷⊃/⌿\\⍀~≠∪∩⊣⊢⍳⍸∊⍷⍋⍒¨⍨⍣.∘⌸⍤⍥⌺@⍠¯→←⍬⍎⍕⋄⍝+" "" t)))

(defvar apl-variable-rx (rx (or "⍺" "⍵")))

(defvar apl-font-lock-keywords
  `(
    (,apl-builtin-rx . font-lock-builtin-face)
    )
  )

(defun dyalogscript-run ()
  (interactive)
  (let ((file-name (buffer-file-name)))
    (with-output-to-temp-buffer "*Dyalogscript Output*"
      (call-process "dyalogscript" nil "*Dyalogscript Output*" t file-name)
      (pop-to-buffer "*Dyalogscript Output*"))))

(define-derived-mode apl-mode fundamental-mode "APL"
  "Major mode for APL"
  (modify-syntax-entry ?⍝ "< b")
  (modify-syntax-entry ?\n "> b")
  (modify-syntax-entry ?' "\"")
  (setq-local comment-start "⍝")
  (setq-local font-lock-defaults '(apl-font-lock-keywords))
  (quail-use-package "apl"))

(add-to-list 'auto-mode-alist '("\\.apl$" . apl-mode))

(define-key apl-mode-map (kbd "C-c C-c") 'dyalogscript-run)
