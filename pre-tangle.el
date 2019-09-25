;;; -*- lexical-binding: t; -*-

(require 'org)
(require 'cl)

(let (added-header)
  (defun my/babel-tangle-body-hook ()
    (let* ((standard-output (current-buffer))
           (code            (buffer-substring-no-properties (point-min) (point-max)))
           (expanded-code   (cl-macroexpand-all (read (format "(progn %s)" code)))))
      (delete-region (point-min) (point-max))
      (unless added-header
        (princ ";;; -*- lexical-binding: t; -*-\n")
        (setq added-header t))
      (prin1 expanded-code))))

(add-to-list 'org-babel-tangle-body-hook 'my/babel-tangle-body-hook)
