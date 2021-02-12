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

(defun upcase-previous-word ()
  (interactive)
  (require 's)
  (let ((start-point (point)))
    (save-excursion
      (backward-word nil)
      (unless (>= (point) start-point)
        (if (s-uppercase-p (buffer-substring (point) start-point))
            (downcase-word 1)
          (upcase-word 1))))))

(defun rename-file-buffer (filename)
  "Rename the current buffer's file."
  (interactive "F")
  (rename-file (buffer-file-name) filename)
  (set-visited-file-name filename))

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
