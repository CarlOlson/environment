;;; -*- lexical-binding: t; -*-

(defun my/try-font (font-name size)
  (if (find-font (font-spec :name font-name :size size))
      (font-spec :name font-name :size size)))

(defun my/get-font (size)
  (or
   (my/try-font "JuliaMono Nerd Font" size)
   (my/try-font "JuliaMono Light" size)
   (my/try-font "AnonymicePro Nerd Font Mono" size)
   (my/try-font "Anonymous Pro" size)
   (my/try-font "Monospace" size)))

(defun my/set-font (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (with-system sm
      (set-frame-font (my/get-font 14)))
    (with-system md
      (set-frame-font (my/get-font 18)))
    (with-system lg
      (set-frame-font (my/get-font 24)))))

(my/set-font)
(add-hook 'after-make-frame-functions 'my/set-font)
(add-hook 'server-visit-hook 'my/set-font)
