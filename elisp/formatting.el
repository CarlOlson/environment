;;; -*- lexical-binding: t; -*-

(defun reindent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun sudo-open-buffer ()
  "Open buffer's file with sudo."
  (interactive)
  (find-file (concat "/sudo::" (buffer-file-name))))

(defun disable-tabs ()
  (interactive)
  (setq-local indent-tabs-mode nil))

(defun remove-tabs ()
  (interactive)
  (disable-tabs)
  (for-each-line
   (delete-char (current-indentation))
   (insert (string-join (make-list tab-width " ")))))

(autoload 's-uppercase-p "s")
(defun upcase-previous-word ()
  (interactive)
  (let ((start-point (point)))
    (save-excursion
      (backward-word nil)
      (unless (>= (point) start-point)
        (if (s-uppercase-p (buffer-substring (point) start-point))
            (downcase-word 1)
          (upcase-word 1))))))

(defun rename-file-buffer ()
  "Rename the current buffer's file."
  (interactive)
  (let ((buffer-name (buffer-file-name)))
    (minibuffer-with-setup-hook
        (lambda () (when buffer-name (insert buffer-name)))
      (call-interactively
       (lambda (filename)
         (interactive "*F")
         (rename-file (buffer-file-name) filename)
         (set-visited-file-name filename))))))

(defun align-repeat (start end regexp)
  "Repeat alignment with respect to the given regexp."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun sort-words (reverse beg end)
  "Sort words in region alphabetically, in REVERSE if negative.
    Prefixed with negative \\[universal-argument], sorts in reverse.
    The variable `sort-fold-case' determines whether alphabetic case
    affects the sort order.
    See `sort-regexp-fields'."
  (interactive "*P\nr")
  (sort-regexp-fields reverse (rx (+ (not space))) "\\&" beg end))

(defun delete-duplicate-words (beg end)
  "Interactivly delete duplicate words or symbols in a region."
  (interactive "r")
  (save-excursion
    (query-replace-regexp (rx (group symbol-start (+? any) symbol-end)
                              (+? space) (backref 1) symbol-end)
                          "\\1" nil beg end)))

(defun kill-this-buffer-quick ()
  "Kills current buffer, but uses `y-or-n-p', not `yes-or-no-p'."
  (interactive)
  (cl-letf (((symbol-function 'yes-or-no-p) #'y-or-n-p))
    (kill-this-buffer)))
