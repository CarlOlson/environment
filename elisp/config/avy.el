;;; -*- lexical-binding: t; -*-

(use-package avy
  :ensure t
  :commands avy
  :autoload avy-jump
  :bind (("C-'" . avy-goto-char-2)
         ("M-'" . avy-goto-char-2)
         ("M-f" . avy-find-file)))

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
  (let ((regex (rx (or bol space blank "(" "file://" "webpack-internal:///")
                   (group (? (or "." ".." "/.")) "/" alnum
                          (+? (or alnum "@" "_" "/" "." "-" "[" "]"))))))
    (avy-jump regex
              :action (lambda (pt)
                        (let (match linenum filename)
                          (save-excursion
                            (goto-char pt)
                            (search-forward-regexp (rx (group (? (or "." ".." "/.")) "/" alnum
                                                              (+ (or alnum "@" "_" "/" "." "-" "[" "]" "\n" "\r")))
                                                       (? (or " " ":") (group (+ num)))))
                            (setq match (match-string 1)
                                  linenum (match-string 2)
                                  filename (my/largest-filename
                                            (my/reduce-concat
                                             (s-split (rx whitespace) match t)))))
                          (when (and (= (length (window-list)) 2)
                                     (equal major-mode 'vterm-mode))
                            (delete-window))
                          ;; TODO focus window if file already shown && windows > 2
                          (find-file-existing filename)
                          (when linenum
                            (goto-char (point-min))
                            (forward-line (1- (string-to-number linenum))))))
              :group 1)))

;; Local Variables:
;; byte-compile-warnings: (not interactive-only)
;; End:
