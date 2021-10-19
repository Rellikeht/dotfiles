(use-package auctex
;  :mode ("\\.\\(la\\)?tex\\'" . auctex-mode)
  :disabled t
  :defer t)
(use-package ac-math
    :mode ("\\.tex\\'" . tex-mode)
    :mode ("\\.latex\\'" . latex-mode))
(use-package cdlatex
    :mode ("\\.latex\\'" . latex-mode))
(use-package latex-math-preview
    :mode ("\\.latex\\'" . latex-mode))
(use-package latex-preview-pane
    :mode ("\\.latex\\'" . latex-mode))
