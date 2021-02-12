;;; -*- lexical-binding: t; -*-

(setq geiser-chez-binary "chezscheme9.5"
      geiser-active-implementations '(chez racket))

(add-hook 'scheme-mode-hook
          (lambda ()
            (add-to-list 'geiser-implementations-alist '((regexp "\\.rkt$") racket ))))

(add-hook 'scheme-mode-hook 'geiser-mode)
(add-hook 'scheme-mode-hook 'company-mode)
(add-hook 'scheme-mode-hook 'eldoc-mode)
(add-hook 'scheme-mode-hook 'prettify-symbols-mode)
