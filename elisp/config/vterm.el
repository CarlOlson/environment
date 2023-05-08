;;; -*- lexical-binding: t; -*-

(defun vterm-kill ()
  "Kill line to both emacs and term kill ring."
  (interactive)
  (vterm-send-key "k" nil nil t)
  (vterm-send-key "k" nil t nil))

(defun vterm-copy-kill-line ()
  (interactive)
  (kill-ring-save
   (point)
   (vterm--get-end-of-line))
  (vterm-copy-mode -1))

(defun vterm-fish-killring (&rest args)
  (interactive)
  (kill-new (string-join args " ")))

(defun vterm-fish-killring-base64 (&rest args)
  (interactive)
  (kill-new (base64-decode-string (string-join args ""))))

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

(use-package vterm
  :commands vterm
  :bind (
         :map vterm-mode-map
         ("M-u" . nil)
         ("M-x" . nil)
         ("M-t" . nil)
         ("M-f" . avy-find-file)

         ("C-h" . self-insert-command)
         ("C-k" . vterm-kill)
         ("C-y" . vterm-yank)
         ("C-SPC" . vterm-copy-mode)

         ("<S-right>" . self-insert-command)
         ("<S-left>" . self-insert-command)
         ("<S-backspace>" . vterm-send-C-w)
         ("<S-delete>" . vterm-send-M-d)

         ("S-RET" . vterm-send-M-b)
         ("C-S-g" . vterm-send-M-f)
         ("C-S-h" . vterm-send-C-w)
         ("C-S-d" . vterm-send-M-d)

         :map vterm-copy-mode-map
         ("C-k" . vterm-copy-kill-line)
         ([remap kill-region] . vterm-copy-mode-done)
         ("q" . vterm-copy-mode)))

(use-package multi-vterm
  :after (hydra vterm)
  :commands (multi-vterm multi-vterm-next multi-vterm-prev)
  :config
  (advice-add 'multi-vterm-next :after 'vterm-reset-cursor-point)
  (advice-add 'multi-vterm-prev :after 'vterm-reset-cursor-point)
  (advice-add 'multi-vterm-project-same-window :after 'vterm-reset-cursor-point))

(defhydra hydra-vterm (global-map "M-t" :timeout 5 :hint nil)
  "vterm"
  ("n" multi-vterm-next "next")
  ("t" multi-vterm-prev "previous")
  ("p" multi-vterm-project-same-window "create in project")
  ("a" multi-vterm-toggle-all "show all")
  ("r" vterm-reset-cursor-point "reset cursor")

  ("c" multi-vterm "create" :exit t)
  ("k" kill-this-buffer-quick "kill" :exit t)
  ("m" magit "magit" :exit t)
  ("M-t" vterm-toggle "toggle" :exit t)
  ("g" ignore "cancel" :exit t)
  ("q" vterm-hide-many "quit" :exit t))
