(require 'org)
(require 'cl)

(defun my/babel-tangle-body-hook ()
  (let* ((standard-output (current-buffer))
         (code            (buffer-substring-no-properties (point-min) (point-max)))
         (context         (substring code 0 (min 50 (length code))))
         (expanded-code   (cl-macroexpand-all (read (format "(progn %s)" code))))
         (error-format    (format "Error: %%s, BEGIN\n%s\nEND" context)))
    (delete-region (point-min) (point-max))
    (prin1 `(let ((debug-on-error nil))
              (with-demoted-errors ,error-format
                (condition-case err ,expanded-code
                  (error
                   (run-with-idle-timer 0 0 (lambda () (switch-to-buffer "*Messages*")))
                   (signal (car err) (cdr err)))))))))

(add-to-list 'org-babel-tangle-body-hook 'my/babel-tangle-body-hook)
