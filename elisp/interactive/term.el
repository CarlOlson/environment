;;; -*- lexical-binding: t; -*-

(defun term-kill ()
  "Kill line to both emacs and term kill ring."
  (interactive)
  (let* ((text (point-to-eol))
         (eol-pattern (rx (* space) eol))
         (eol-index (string-match eol-pattern text))
         (text (substring-no-properties text 0 eol-index)))
    (kill-new text)
    (if (equal major-mode 'vterm-mode)
        (vterm-send-key "k" nil nil t)
      (term-send-raw-string ""))))

(defun vterm-hide-many ()
  "Hide vterm buffers until last non-vterm buffer reached."
  (interactive)
  (while (equal major-mode 'vterm-mode)
    (previous-buffer)))

(defun vterm-toggle ()
  "Switch between buffer and vterm"
  (interactive)
  (let ((buffer (get-vterm-buffer)))
    (cond
     ((equal major-mode 'vterm-mode)
      (vterm-hide-many))
     ((null buffer)
      (multi-vterm))
     (t
      (switch-to-buffer buffer)))))

(defun open-term-from-outside ()
  "Open a terminal from an external command."
  (interactive)
  (let ((buffer (get-vterm-buffer)))
    (cond
     ((null buffer)
      (multi-vterm))
     (t
      (switch-to-buffer buffer)))))

(defun get-vterm-buffer ()
  (cl-dolist (buffer (buffer-list))
    (when (with-current-buffer buffer
            (equal major-mode 'vterm-mode))
      (cl-return buffer))))

(defun vterm-rg (filename)
  "Used by shell to open `rg' results in emacs."
  (interactive)
  (when (file-exists-p filename)
    (compilation-start (format "cat %s" filename) 'grep-mode)))

(defun multi-vterm-project-same-window ()
  "Open vterm for project, but don't open another window."
  (interactive)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (multi-vterm-project)))

(defun vterm-navigate ()
  "Easier control of multiple vterm buffers."
  (interactive)
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     (define-key map (kbd "c") 'multi-vterm)
     (define-key map (kbd "n") 'multi-vterm-next)
     (define-key map (kbd "t") 'multi-vterm-prev)
     (define-key map (kbd "p") 'multi-vterm-project-same-window)
     (define-key map (kbd "q") 'vterm-hide-many)
     (define-key map (kbd "k") 'kill-this-buffer-quick)
     (define-key map (kbd "m") 'magit)
     (define-key map (kbd "M-t") 'vterm-toggle)
     map)
   (lambda ()
     (member (this-command-keys) '("c" "n" "t" "p" "q")))))
