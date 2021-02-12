;;; -*- lexical-binding: t; -*-

(defun insert-with-input-method (input-method prompt)
  (unwind-protect
      (progn
        (set-input-method input-method)
        (insert-string
         (read-from-minibuffer prompt nil nil nil nil nil t))
        (deactivate-input-method))))

(defun insert-hiragana ()
  (interactive)
  (insert-with-input-method 'japanese-hiragana "Hiragana: "))

(defun insert-katakana ()
  (interactive)
  (insert-with-input-method 'japanese-katakana "Katakana: "))
