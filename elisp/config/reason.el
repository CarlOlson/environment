;;; -*- lexical-binding: t; -*-

(define-derived-mode rescript-mode reason-mode "ReScript"
  "Major mode for editing ReScript.")

(modify-syntax-entry ?\\ "\\ p" rescript-mode-syntax-table)
(modify-syntax-entry ?` "\"" rescript-mode-syntax-table)

(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "/home/carl/.local/rls-linux/reason-language-server")
                    :major-modes '(reason-mode)
                    :notification-handlers (ht ("client/registerCapability" 'ignore))
                    :priority 1
                    :server-id 'reason-ls))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "/home/carl/git/environment/rescript-lsp.sh")
    :major-modes '(rescript-mode)
    :notification-handlers (ht ("client/registerCapability" 'ignore))
    :priority 1
    :server-id 'rescript-ls))
  (add-to-list 'lsp-language-id-configuration (cons ".*\\.res$" "rescript"))
  (add-to-list 'lsp-language-id-configuration (cons ".*\\.resi$" "rescript")))

(defun reason-fill-paragraph ()
  (interactive)
  (with-temp-buffer-swap
    (c-mode)
    (c-fill-paragraph)))

(defun my/reason-mode-hook ()
  (lsp t)
  (setq-local company-minimum-prefix-length 3)
  (setq-local company-idle-delay 0.5)
  (setq-local lsp-response-timeout 2)
  (setq-local indent-line-function 'indent-relative)
  (setq-local comment-auto-fill-only-comments t)
  (setq-local comment-multi-line t))

(cl-defun bsc-format-buffer ()
  (interactive)
  (when (buffer-modified-p)
    (save-buffer)
    (when (member 'bsc-format-buffer after-save-hook)
      (cl-return-from bsc-format-buffer)))
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

(add-to-list 'auto-mode-alist '("\\.res$" . rescript-mode))
(add-to-list 'auto-mode-alist '("\\.resi$" . rescript-mode))
(add-to-list 'auto-mode-alist '("\\.re$" . reason-mode))
(add-to-list 'auto-mode-alist '("\\.rei$" . reason-mode))
