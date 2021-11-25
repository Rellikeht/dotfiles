;; Associating file types with modes
;(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
;(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
;(add-to-list 'auto-mode-alist '("\\.scm\\'" . lisp-mode))
;(add-to-list 'auto-mode-alist '("\\.clj\\'" . lisp-mode))
;(add-to-list 'auto-mode-alist '("\\.el\\'" . lisp-mode))

(defun start-slime-async ()
  (interactive)
  (async-run-sexp
   (slime)
   (sleep-for 2)
   (delete-window)
   (buffer-next)
   (buffer-next)))

(defun start-slime ()
  (interactive)
  (progn
    (slime)
    (sleep-for 2)
    (delete-window)))

(use-package slime
  :ensure t
  :defer t
  :mode ("\\.\\(scm\\|lisp\\|clj\\|cl\\)\\'" . lisp-mode)
  :config
  (setq slime-lisp-implementations
	`((sbcl ("/bin/sbcl"))
	  (clisp ("/bin/clisp")))))
;	     (start-slime-async))
;  (slime)
;    (backward-other-window))
;    (next-buffer)
;    (next-buffer)
;    (next-buffer)
;    (slime-mode))

(add-to-list
 'auto-mode-alist
 '("\\.\\(cl\\|lisp\\|scm\\|clj\\|el\\)\\'" . lisp-mode))

(use-package slime-company
  :disabled t
  :mode ("\\.\\(scm\\|lisp\\|clj\\|cl\\)\\'" . slime-mode))

(use-package highlight-parentheses
  :ensure t
  :mode ("\\.\\(el\\|scm\\|lisp\\|clj\\|cl\\)\\'" . lisp-mode))
