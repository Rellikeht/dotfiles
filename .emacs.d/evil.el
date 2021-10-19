(use-package evil)
(evil-mode 1)
(use-package evil-args)
;(use-package phi-search)
;(use-package multiple-cursors)

(setf evil-undo-system 'undo-tree)

(load (concat user-emacs-directory "evil-keys.el"))
