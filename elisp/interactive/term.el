;;; -*- lexical-binding: t; -*-

(defun term-kill ()
  "Kill line to both emacs and term kill ring."
  (interactive)
  (let* ((text (point-to-eol))
         (eol-pattern (rx (* space) eol))
         (eol-index (string-match eol-pattern text))
         (text (substring text 0 eol-index)))
    (kill-new text)
    (if (equal major-mode 'vterm-mode)
        (vterm-send-key "k" nil nil t)
      (term-send-raw-string ""))))

(defun term-toggle ()
  "Switch between buffer and terminal"
  (interactive)
  (let ((buffer (get-term-buffer)))
    (cond
     ((eq (current-buffer) buffer)
      (previous-buffer)
      (bury-buffer buffer))
     ((null buffer)
      (vterm))
     ((null (get-buffer-process buffer))
      (kill-buffer buffer)
      (projectile-run-vterm))
     (t
      (switch-to-buffer buffer)))))

(defun open-term-from-outside ()
  "Open a terminal from an external command."
  (interactive)
  (let ((buffer (get-term-buffer)))
    (cond
     ((null buffer)
      (vterm))
     (t
      (switch-to-buffer buffer)))))

(defun get-term-buffer ()
  (dolist (buffer (buffer-list))
    (when (with-current-buffer buffer
            (equal major-mode 'vterm-mode))
      (return buffer))))

(defun vterm-rg (filename)
  (interactive)
  (when (file-exists-p filename)
    (compilation-start (format "cat %s" filename) 'grep-mode)))

(add-hook 'grep-mode-hook (lambda () (interactive) (setq-local truncate-lines t)))
