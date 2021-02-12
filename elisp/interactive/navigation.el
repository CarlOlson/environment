;;; -*- lexical-binding: t; -*-

(defun select-next-window ()
  (interactive)
  (select-window (next-window)))

(defun select-prev-window ()
  (interactive)
  (select-window (previous-window)))

(defmacro point-after-calls (&rest body)
  `(condition-case-unless-debug nil
       (save-excursion ,@body (point))
     (error nil)))

(defun my-word-boundary-points ()
  (list-of-not-nil
   (point-after-calls (forward-word))
   (point-after-calls (backward-word))
   (point-after-calls (back-to-indentation))
   (point-after-calls (forward-line) (back-to-indentation))
   (point-after-calls (forward-line -1) (end-of-line))))

(defun delete-forward-word ()
  (interactive)
  (let* ((start-point (point))
         (end-point
          (car
           (cl-sort
            (cl-remove-if (lambda (point) (<= point start-point))
                          (my-word-boundary-points))
            '<))))
    (when end-point
      (delete-region start-point end-point))))

(defun delete-backward-word ()
  (interactive)
  (let* ((start-point (point))
         (end-point
          (car
           (cl-sort
            (cl-remove-if (lambda (point) (>= point start-point))
                          (my-word-boundary-points))
            '>))))
    (when end-point
      (delete-region start-point end-point))))
