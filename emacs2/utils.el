;;; -*- no-byte-compile: t; lexical-binding: t; -*-

(defun remove-lighter (mode)
  "Remove the lighter from the tray for `mode'."
  (setf (cadr (assoc mode minor-mode-alist)) ""))

(defun point-to-eol ()
  "Returns the text from current point to the end of line."
  (buffer-substring (point) (point-at-eol)))

(defmacro with-each-line (&rest body)
  "Evaluate BODY at every line in current buffer."
  (declare (indent 0) (debug t))
  (let ((last-point (gensym "last-point")))
    `(save-excursion
       (goto-char (point-min))
       (while (not (eq (point) (point-max)))
         (let ((,last-point (point)))
           ,@body
           (goto-char ,last-point)
           (end-of-line)
           (forward-char))))))

(defun list-of-not-nil (&rest args)
  "Removes nulls from a list on creation."
  (cl-remove nil args))

(defun between (a b c)
  "Is `c' between `a' and `b'?"
  (<= a c b))

(defmacro with-temp-buffer-swap (&rest body)
  (declare (indent 0) (debug t))
  (let ((this-buffer (gensym "this-buffer"))
        (temp-buffer (gensym "temp-buffer"))
        (point       (gensym "point")))
    `(let ((,this-buffer (current-buffer))
           (,point (point)))
       (with-temp-buffer
         (replace-buffer-contents ,this-buffer)
         (goto-char ,point)
         ,@body
         (let ((,temp-buffer (current-buffer)))
           (with-current-buffer ,this-buffer
             (replace-buffer-contents ,temp-buffer)))))))

(defun alert-self ()
  (interactive)
  (unless (or (cl-find (current-buffer) (window-list) :key 'window-buffer)
              (active-minibuffer-window))
    (let ((buffer (current-buffer)))
      (view-buffer-other-window buffer)
      (run-with-idle-timer 6 nil (lambda ()
                                   (with-current-buffer buffer
                                     (when view-mode
                                       (View-quit))))))))
