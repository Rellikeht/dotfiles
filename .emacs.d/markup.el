(use-package ac-html
  :ensure t
  :mode ("\\.\\(html?\\|xml\\|svg\\)\\'" . html-mode))
(use-package svg
  :ensure t
  :mode ("\\.svg\\'" . nil))
(use-package w3m
  :ensure t
  :mode ("\\.html?\\'" . w3m))
(use-package markdown-preview-eww
  :ensure t
  :defer t)
;  :mode (".md" . markdown-preview-eww))
