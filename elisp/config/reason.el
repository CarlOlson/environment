;;; -*- lexical-binding: t; -*-

(define-derived-mode rescript-mode reason-mode "ReScript"
  "Major mode for editing ReScript.")

(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "/home/carl/.local/rls-linux/reason-language-server")
                    :major-modes '(reason-mode)
                    :notification-handlers (ht ("client/registerCapability" 'ignore))
                    :priority 1
                    :server-id 'reason-ls))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "/home/carl/git/rescript-vscode/server/linux/rescript-editor-support.exe")
    :major-modes '(rescript-mode)
    :notification-handlers (ht ("client/registerCapability" 'ignore))
    :priority 1
    :server-id 'rescript-ls))
  (add-to-list 'lsp-language-id-configuration (cons ".*\\.res$" "rescript")))

(defun reason-fill-paragraph ()
  (interactive)
  (let* ((point (point))
         (text (buffer-string))
         (text (with-temp-buffer
                 (insert text)
                 (goto-char point)
                 (c-mode)
                 (c-fill-paragraph)
                 (buffer-substring-no-properties (point-min) (point-max)))))
    (save-mark-and-excursion
      (erase-buffer)
      (insert text))
    (goto-char point)))

(defun my/reason-mode-hook ()
  (require 'cc-mode)
  (lsp t)
  (setq-local company-minimum-prefix-length 3)
  (setq-local company-idle-delay 0.5)
  (setq-local lsp-response-timeout 2)
  (setq-local indent-line-function 'indent-relative)
  (setq-local comment-auto-fill-only-comments t)
  (setq-local comment-multi-line t))

(defun bsc-format-buffer ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (this-buffer (current-buffer)))
    (with-temp-buffer
      (anaphoric-block nil
        (call-process "yarn" nil t nil
                      "-s" "bsc" "-color" "never" "-format" file-name)
        (when (not (zerop it))
          (message "%s" (buffer-substring-no-properties (point-min) (point-max)))
          (cl-return))
        (let ((temp-buffer (current-buffer)))
          (with-current-buffer this-buffer
            (replace-buffer-contents temp-buffer)))))))

(add-hook 'reason-mode-hook #'my/reason-mode-hook)
(add-hook 'rescript-mode-hook #'my/reason-mode-hook)
(add-to-list 'auto-mode-alist '("\\.res?$" . rescript-mode))
