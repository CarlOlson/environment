;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'scheme-mode
  (add-hook 'scheme-mode-hook 'geiser-mode)
  (add-hook 'scheme-mode-hook 'company-mode)
  (add-hook 'scheme-mode-hook 'eldoc-mode)
  (add-hook 'scheme-mode-hook 'prettify-symbols-mode))
