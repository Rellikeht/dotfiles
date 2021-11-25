(use-package ccls
  :ensure t
  :mode ("\\.\\(c\\|h\\)\\'" . c-mode))

(use-package cython-mode
  :ensure t
  :mode ("\\.pyx\\'" . cython-mode))

(use-package dante
  :ensure t
  :mode ("\\.hs\\'" . haskell-mode))

(use-package elpy
  :ensure t
  :mode ("\\.pyd?\\'" . python-mode))
