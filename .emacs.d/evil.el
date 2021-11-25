(use-package evil
  :ensure t)
(evil-mode 1)
(use-package evil-args
  :ensure t)
;(use-package phi-search)
;(use-package multiple-cursors)

(setf evil-undo-system 'undo-tree)

(load (concat user-emacs-directory "evil-keys.el"))
