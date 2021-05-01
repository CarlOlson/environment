;;; -*- lexical-binding: t; -*-

(autoload 'avy-jump "avy")
(autoload 's-replace "s")

(defun avy-find-file ()
  (interactive)
  (let ((regex (rx (or bol space blank)
                   (group "/" alnum
                          (+? (or alnum "@" "_" "/" "." "-" "\n"))))))
    (avy-jump regex
              :action (lambda (pt)
                        (let (filename linenum)
                          (save-excursion
                            (goto-char pt)
                            (search-forward-regexp (rx (group "/" (+ (or alnum "@" "_" "/" "." "-" "\n")))
                                                       (? " " (group (+ num)))))
                            (setq filename (s-replace "\n" "" (match-string 1))
                                  linenum (match-string 2)))
                          (find-file-existing filename)
                          (when linenum
                            (goto-line (string-to-number linenum)))))
              :group 1)))

;; Local Variables:
;; byte-compile-warnings: (not interactive-only)
;; End:
