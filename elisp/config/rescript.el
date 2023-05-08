;;; -*- lexical-binding: t; -*-

(use-package rescript-mode
  :commands rescript-mode
  :load-path "/home/carl/git/rescript-mode"
  :bind (
         :map rescript-mode-map
         ("M-q" . rescript-fill-paragraph)
         ("C-c p s" . projectile-toggle-between-implementation-and-test)
         ("C-c p t" . projectile-test-project)
         ("C-c p c" . projectile-compile-project)
         ("C-c <tab>" . rescript-format-buffer)
         )
  :init
  (add-to-list 'auto-mode-alist '("\\.resi?$" . rescript-mode))
  :config
  (add-hook 'rescript-mode-hook #'my/rescript-mode-hook))

(use-package reason-mode
  :commands reason-mode
  :bind (:map reason-mode-map ("C-c <tab>" . bsrefmt-file))
  :config
  (setq auto-mode-alist (cl-remove-if
                         (lambda (x) (equal (cdr x) 'reason-mode))
                         auto-mode-alist))
  (add-to-list 'auto-mode-alist '("\\.rei?$" . reason-mode)))

(eval-and-compile
  (require 'cl-lib)
  (require 's))

(eval-when-compile
  (require 'cc-mode)
  (require 'anaphora))

(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "/home/carl/git/environment/rescript-lsp.sh")
    :major-modes '(rescript-mode)
    :priority 1
    :server-id 'rescript-ls))
  (add-to-list 'lsp-language-id-configuration (cons ".*\\.resi?$" "rescript")))

(defun rescript-fill-paragraph ()
  (interactive)
  (with-temp-buffer-swap
    (c-mode)
    (c-fill-paragraph)))

(defun my/rescript-mode-hook ()
  (lsp t)
  (setq-local company-minimum-prefix-length 1)
  (setq-local company-idle-delay 0.2)
  (setq-local lsp-response-timeout 2)
  (setq-local indent-line-function 'indent-relative)
  (setq-local comment-auto-fill-only-comments t)
  (setq-local comment-multi-line t))

(cl-defun rescript-format-buffer ()
  (interactive)
  (let ((this-buffer (current-buffer))
        (extension (file-name-extension (buffer-file-name) t)))
    (when (buffer-modified-p)
      (delete-trailing-whitespace))
    (with-temp-buffer
      (anaphoric-block nil
        (replace-buffer-contents this-buffer)
        (if (f-join (projectile-project-root) "yarn.lock")
            (call-process-region (point-min) (point-max) "yarn" t t nil
                                 "run" "-T" "rescript" "format" "-stdin" extension)
          (call-process-region (point-min) (point-max) "rescript" t t nil
                               "format" "-stdin" extension))
        (when (not (zerop it))
          (message "%s" (buffer-substring-no-properties (point-min) (point-max)))
          (cl-return))
        (let ((temp-buffer (current-buffer)))
          (with-current-buffer this-buffer
            (replace-buffer-contents temp-buffer)
            (save-buffer)))))))

(autoload 's-ends-with? "s")
(cl-defun reason-to-rescript ()
  (interactive)
  (require 'dash)
  (when (buffer-modified-p (current-buffer))
    (message "Save buffer first!")
    (cl-return-from reason-to-rescript))
  (let* ((re-buffer (current-buffer))
         (re-file-name (buffer-file-name))
         (is-interface (s-ends-with? "i" (buffer-file-name)))
         (res-ext (if is-interface ".resi" ".res"))
         (res-file-name
          (->
           (buffer-file-name)
           (file-name-sans-extension)
           (concat res-ext))
          )
         (status-code
          (call-process "yarn" nil nil nil "dlx" "rescript@9" "convert" re-file-name)))
    (when (eq status-code 0)
      (find-file-existing res-file-name)
      (kill-buffer-if-not-modified re-buffer))))

(defun bsrefmt-file ()
  (interactive)
  (let ((point (point)))
    (call-process-region nil nil "bsrefmt" t t nil)
    (goto-char point)))
