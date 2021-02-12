;;; -*- lexical-binding: t; -*-

(add-hook 'python-mode-hook 'blacken-mode)
(add-hook 'python-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-jedi)
