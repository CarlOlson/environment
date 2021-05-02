;;; -*- lexical-binding: t; -*-

(autoload 'avy-jump "avy")
(autoload 's-split "s")
(autoload '-max-by "dash")

(defun my/max-string (strings)
  (-max-by (lambda (a b)
             (> (length a) (length b)))
           strings))

(defun my/largest-filename (filenames)
  (my/max-string
   (cl-remove-if-not 'file-exists-p filenames)))

(defun my/reduce-concat (strings)
  (cl-labels ((rec (parts working output)
                   (if (null parts)
                       output
                     (rec (cdr parts)
                          (concat working (car parts))
                          (cons (concat working (car parts)) output)))))
    (rec strings "" '())))

(defun avy-find-file ()
  (interactive)
  (let ((regex (rx (or bol space blank "(")
                   (group (? ".") "/" alnum
                          (+? (or alnum "@" "_" "/" "." "-" "\n"))))))
    (avy-jump regex
              :action (lambda (pt)
                        (let (filename linenum)
                          (save-excursion
                            (goto-char pt)
                            (search-forward-regexp (rx (group (? ".") "/" (+ (or alnum "@" "_" "/" "." "-" "\n")))
                                                       (? (or " " ":") (group (+ num)))))
                            (setq filename (my/largest-filename
                                            (my/reduce-concat
                                             (s-split "\n" (match-string 1) t)))
                                  linenum (match-string 2)))
                          (find-file-existing filename)
                          (when linenum
                            (goto-char (point-min))
                            (forward-line (1- (string-to-number linenum))))))
              :group 1)))

;; Local Variables:
;; byte-compile-warnings: (not interactive-only)
;; End:
