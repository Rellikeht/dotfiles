(use-package auctex
;  :mode ("\\.\\(la\\)?tex\\'" . auctex-mode)
  :disabled t
  :defer t)
(use-package ac-math
  :ensure t
  :mode ("\\.tex\\'" . tex-mode)
  :mode ("\\.latex\\'" . latex-mode))
(use-package cdlatex
  :ensure t
  :mode ("\\.latex\\'" . latex-mode))
(use-package latex-math-preview
  :ensure t
  :mode ("\\.latex\\'" . latex-mode))
(use-package latex-preview-pane
  :ensure t
  :mode ("\\.latex\\'" . latex-mode))
