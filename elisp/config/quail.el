;;; -*- lexical-binding: t; -*-

(require 'quail)

(defun quail-lambda-start ()
  (interactive)
  (quail-use-package "lambda"))

(defun quail-apl-start ()
  (interactive)
  (quail-use-package "apl"))

(quail-define-package
 "lambda" "UTF-8" "λ" t
 "lambda input method for functional programming"
 nil nil nil nil nil nil t)

(quail-define-package
 "apl" "UTF-8" "⍝" t
 "input method for APL programming"
 nil nil nil nil nil nil t)

(quail-defrule ",iff" ["⇔"] "lambda")
(quail-defrule ",ift" ["⇒"] "lambda")
(quail-defrule ",not" ["¬"] "lambda")
(quail-defrule ",and" ["∧"] "lambda")
(quail-defrule ",or" ["∨"] "lambda")
(quail-defrule ",xor" ["⊕"] "lambda")
(quail-defrule ",pxor" ["↮"] "lambda") ; philosophy xor
(quail-defrule ",top" ["⊤"] "lambda")
(quail-defrule ",bot" ["⊥"] "lambda")
(quail-defrule ",forall" ["∀"] "lambda")
(quail-defrule ",exists" ["∃"] "lambda")
(quail-defrule ",proves" ["⊢"] "lambda")
(quail-defrule ",tee" ["⊢"] "lambda")
(quail-defrule ",models" ["⊨"] "lambda")
(quail-defrule ",define" ["≔"] "lambda")

;; APL characters
(dolist (pair '(("C" ?⍝) ; comment
                ("d" ?⋄) ; diamond
                ("-" ?¯) ; icon
                ("-," ?⍪) ; icon
                ("*" ?×) ; icon
                ("/" ?÷) ; icon
                ("/-" ?⌿) ; icon
                ("\\-" ?⍀) ; icon
                (">" ?≥) ; icon
                ("<" ?≤) ; icon
                ("=/" ?≠) ; icon (not equal)
                ("m/" ?≢) ; icon (not match)
                ("m" ?≡) ; match (depth)
                ("z" ?⍬) ; zilde (zero +‎ tilde)
                ("p" ?⊆) ; partition

                ("i" ?⍳) ; index
                ("i_" ?⍸) ; icon

                ("e" ?∊) ; icon
                ("e_" ?⍷) ; icon

                ("Q" ?⌷) ; (quad) squish
                ("q" ?⎕) ; quad
                ("q'" ?⍞)
                ("q=" ?⌸)
                ("qd" ?⌺) ; quad diamond (stencil)
                ("q:" ?⍠)
                ("q:-" ?⌹)

                ("n" ?∇) ; nabla
                ("a" ?⍺) ; greek keyboard
                ("v" ?⍵) ; greek keyboard
                ("r" ?⍴) ; greek keyboard (reshape)
                ("S" ?⍨) ; S combinator (commute)
                ("c" ?⌈) ; left ceiling
                ("f" ?⌊) ; left floor

                ("ba" ?∧) ; boolean AND
                ("bo" ?∨) ; boolean OR
                ("ban" ?⍲) ; boolean AND NOT
                ("bon" ?⍱) ; boolean OR NOT

                (":" ?¨) ; (each)
                (":o" ?⍤) ; (rank)
                (":O" ?⍥) ; (over)
                (":~" ?⍨) ; (commute)
                (":*" ?⍣) ; (power)

                ("o|" ?⌽) ; icon (reverse)
                ("o-" ?⊖) ; icon (leading reverse)
                ("o\\" ?⍉) ; icon (transpose)
                ("o*" ?⍟) ; icon (logarithm)
                ("o" ?∘) ; icon (inner)
                ("O" ?○) ; icon (circular)

                ("gt" ?⍋) ; grade up
                ("gn" ?⍒) ; grade down

                ("th" ?⊣) ; tack left
                ("ts" ?⊢) ; tack right
                ("tt" ?⊥) ; tack up
                ("tn" ?⊤) ; tack down
                ("tno" ?⍕) ; tack down (up) jot
                ("tto" ?⍎) ; tack up (down) jot

                ("sh" ?⊂) ; shoe left
                ("ss" ?⊃) ; shoe right
                ("st" ?∩) ; shoe up
                ("sn" ?∪) ; shoe down

                ("ah" ?←) ; arrow left
                ("as" ?→) ; arrow right
                ("at" ?↑) ; arrow up
                ("an" ?↓) ; arrow down
                ))
  (quail-defrule (concat "," (car pair)) (cdr pair) "apl")
  (quail-defrule (concat ",a" (car pair)) (cdr pair) "lambda"))

;; greek characters
(dolist (pair '(("a" ?α)
                ("b" ?β)
                ("c" ?ψ)
                ("d" ?δ)
                ("e" ?ε)
                ("f" ?φ)
                ("g" ?γ)
                ("h" ?η)
                ("i" ?ι)
                ("j" ?ξ)
                ("k" ?κ)
                ("l" ?λ)
                ("m" ?μ)
                ("n" ?ν)
                ("o" ?ο)
                ("p" ?π)
                ("r" ?ρ)
                ("s" ?σ)
                ("t" ?τ)
                ("u" ?θ)
                ("v" ?ω)
                ("w" ?ς)
                ("x" ?χ)
                ("y" ?υ)
                ("z" ?ζ)

                ("C" ?Ψ)
                ("D" ?Δ)
                ("F" ?Φ)
                ("G" ?Γ)
                ("J" ?Ξ)
                ("L" ?Λ)
                ("P" ?Π)
                ("S" ?Σ)
                ("U" ?Θ)
                ("V" ?Ω)))
  (quail-defrule (concat ",g" (car pair)) (cdr pair) "apl")
  (quail-defrule (concat ",g" (car pair)) (cdr pair) "lambda"))

(define-key quail-translation-keymap (kbd "C-h") nil)

(add-hook 'emacs-lisp-mode-hook 'quail-lambda-start)

(with-eval-after-load "racket-mode"
  (add-hook 'racket-mode-hook 'quail-lambda-start)
  (add-hook 'racket-mode-hook 'company-mode))
