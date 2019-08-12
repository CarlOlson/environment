(require 'org)
(require 'cl)

(defun my/babel-tangle-body-hook ()
  (let ((standard-output (current-buffer))
        (code (buffer-string)))
    (delete-region (point-min) (point-max))
    (princ (cl-subst code '%s
                     `(let ((lexical-binding t))
                        (condition-case err
                            (progn %s)
                          (error
                           (run-with-idle-timer
                            0 nil (lambda () (signal (car err) (cdr err)))))))))))

(add-to-list 'org-babel-tangle-body-hook 'my/babel-tangle-body-hook)
