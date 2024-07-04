(with-eval-after-load 'key-chord
  (defun insert-question-mark ()
    (interactive)
    (funcall-interactively 'self-insert-command 1 ??))

  (defun insert-right-bracket ()
    (interactive)
    (funcall-interactively 'self-insert-command 1 ?\[))

  (defun insert-left-bracket ()
    (interactive)
    (funcall-interactively 'self-insert-command 1 ?\]))

  (defun insert-right-brace ()
    (interactive)
    (funcall-interactively 'self-insert-command 1 ?\{))

  (defun insert-left-brace ()
    (interactive)
    (funcall-interactively 'self-insert-command 1 ?\}))

  (key-chord-define-global [?p ?v] 'insert-question-mark)
  (key-chord-define-global [?p ?t] 'insert-right-bracket)
  (key-chord-define-global [?p ?n] 'insert-left-bracket)
  (key-chord-define-global [?p ?c] 'insert-right-brace)
  (key-chord-define-global [?p ?r] 'insert-left-brace))

;; problem words w/ cords
;;; problem ]oblem
;;; promise ]omise
;;; option o{ion
;;; probably ]obably
