;;; -*- lexical-binding: t; -*-

(defmacro with-system (tags &rest body)
  "Evaluate BODY if `system-type' equals TYPE."
  (declare (indent 1))
  `(when (cl-every #'is-system-like ',(if (listp tags) tags (list tags)))
     ,@body))

(defun is-system-like (tag)
  (aif (is-not-tag tag)
      (not (is-system-like it))
    (pcase tag
      ('wsl (and (file-exists-p "/mnt/c/Windows")
                 (eq system-type 'gnu/linux)))
      ('linux (eq system-type 'gnu/linux))
      ('osx (eq system-type 'darwin))
      ('x11 (is-x11))
      ('tty (is-tty))
      ('sm (<= 0 (display-pixel-height) 720))
      ('md (<= 721 (display-pixel-height) 1080))
      ('lg (<= 1081 (display-pixel-height)))
      (type (eq system-type type)))))

(defun is-not-tag (tag)
  (when (string-match (rx bol "not-" (group (+ any)) eol)
                      (symbol-name tag))
    (intern (match-string-no-properties 1 (symbol-name tag)))))

(defun is-tty ()
  (not (seq-empty-p (tty-type))))

(defun is-x11 ()
  (not (seq-empty-p (x-display-list))))

(defun remove-lighter (mode)
  "Remove the lighter from the tray for `mode'."
  (setf (cadr (assoc mode minor-mode-alist)) ""))

(defun point-to-eol ()
  "Returns the text from current point to the end of line."
  (buffer-substring (point) (point-at-eol)))

(defmacro for-each-line (&rest body)
  "Evaluate BODY at every line in current buffer."
  `(save-excursion
     (goto-char (point-min))
     (while (not (eq (point) (point-max)))
       (let ((last-point (point)))
         ,@body
         (goto-char last-point)
         (end-of-line)
         (forward-char)))))

(defun list-of-not-nil (&rest args)
  "Removes nulls from a list on creation."
  (cl-remove nil args))

(defun burn-on-call (fn)
  "Return a function that will only evalute once.  Returns `nil'
  on after first call."
  (let ((evaluated nil) (fn fn))
    (lambda (&rest args)
      (unless evaluated
        (unwind-protect (apply fn args)
          (setf evaluated t))))))

(defun between (a b c)
  "Is `c' between `a' and `b'?"
  (<= a c b))

(defun my/print-buffer (buffer-or-name)
  "Print BUFFER-OR-NAME contents to stderr"
  (with-current-buffer buffer-or-name
    (princ (buffer-substring (point-min) (point-max))
           #'external-debugging-output)))

(defun my/compile-init ()
  "Compile init.el to init.elc"
  (byte-compile-file "~/.emacs.d/init.el")
  (my/print-buffer "*Compile-Log*"))

(defun mb-to-bytes (value)
  "Convert megabytes to bytes"
  (* value 1000 1000))

(defmacro with-temp-buffer-swap (&rest body)
  (declare (indent 0) (debug t))
  (let ((this-buffer (make-symbol "this-buffer"))
        (temp-buffer (make-symbol "temp-buffer"))
        (point       (make-symbol "point")))
    `(let ((,this-buffer (current-buffer))
           (,point (point)))
       (with-temp-buffer
         (replace-buffer-contents ,this-buffer)
         (goto-char ,point)
         ,@body
         (let ((,temp-buffer (current-buffer)))
           (with-current-buffer ,this-buffer
             (replace-buffer-contents ,temp-buffer)))))))
