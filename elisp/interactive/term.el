;;; -*- lexical-binding: t; -*-

(defun vterm-kill ()
  "Kill line to both emacs and term kill ring."
  (interactive)
  (vterm-send-key "k" nil nil t)
  (vterm-send-key "k" nil t nil))

(defun vterm-fish-killring (&rest args)
  (interactive)
  (kill-new (string-join args " ")))

(defun vterm-hide-many ()
  "Hide vterm buffers until last non-vterm buffer reached."
  (interactive)
  (when (equal major-mode 'vterm-mode)
    (let ((inhibit-message t))
      (clean-buffer-list)))
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
      (switch-to-buffer buffer)
      (vterm-reset-cursor-point)))))

(defun open-term-from-outside ()
  "Open a terminal from an external command."
  (interactive)
  (let ((buffer (get-vterm-buffer)))
    (cond
     ((null buffer)
      (multi-vterm))
     (t
      (switch-to-buffer buffer)
      (vterm-reset-cursor-point)))))

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

(advice-add 'multi-vterm-next :after 'vterm-reset-cursor-point)
(advice-add 'multi-vterm-prev :after 'vterm-reset-cursor-point)
(advice-add 'multi-vterm-project-same-window :after 'vterm-reset-cursor-point)

(defun multi-vterm-toggle-all ()
  (interactive)
  (delete-other-windows-internal)
  (cond
   ((equal major-mode 'vterm-mode)
    (vterm-hide-many))
   (t
    (dolist (buffer multi-vterm-buffer-list)
      (when (equal major-mode 'vterm-mode)
        (split-window)
        (other-window 1))
      (switch-to-buffer buffer)))))

(defun vterm-navigate ()
  "Easier control of multiple vterm buffers."
  (interactive)
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     (define-key map (kbd "c") 'multi-vterm)
     (define-key map (kbd "n") 'multi-vterm-next)
     (define-key map (kbd "t") 'multi-vterm-prev)
     (define-key map (kbd "p") 'multi-vterm-project-same-window)
     (define-key map (kbd "a") 'multi-vterm-toggle-all)
     (define-key map (kbd "q") 'vterm-hide-many)
     (define-key map (kbd "k") 'kill-this-buffer-quick)
     (define-key map (kbd "r") 'vterm-reset-cursor-point)
     (define-key map (kbd "m") 'magit)
     (define-key map (kbd "M-t") 'vterm-toggle)
     (define-key map (kbd "g") 'ignore)
     map)
   (lambda ()
     (member (this-command-keys) '("a" "n" "t" "p" "q" "r")))))
