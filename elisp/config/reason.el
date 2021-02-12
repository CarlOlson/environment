;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'reason-mode
  (require 'lsp-mode)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "/home/carl/.local/rls-linux/reason-language-server")
                    :major-modes '(reason-mode)
                    :notification-handlers (ht ("client/registerCapability" 'ignore))
                    :priority 1
                    :server-id 'reason-ls)))

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

(add-hook 'reason-mode-hook #'my/reason-mode-hook)
