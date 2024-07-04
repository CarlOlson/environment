;;; -*- lexical-binding: t; -*-

(defun my/try-font (font-name size)
  (alet (font-spec :name font-name :size size)
    (if (find-font it) it)))

(defun my/get-font (size)
  (or
   (my/try-font "JuliaMono Light" size)
   (my/try-font "Anonymice Nerd Font Mono" size)
   (my/try-font "Anonymous Pro" size)
   (my/try-font "Monospace" size)))

(defun my/set-font (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (with-system sm
      (set-frame-font (my/get-font 14)))
    (with-system md
      (set-frame-font (my/get-font 18)))
    (with-system lg
      (set-frame-font (my/get-font 28)))))

(my/set-font)
(add-hook 'after-make-frame-functions 'my/set-font)
(add-hook 'server-visit-hook 'my/set-font)
