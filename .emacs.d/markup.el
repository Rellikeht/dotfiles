(use-package ac-html
  :mode ("\\.\\(html?\\|xml\\|svg\\)\\'" . html-mode))
(use-package svg
  :mode ("\\.svg\\'" . nil))
(use-package w3m
  :mode ("\\.html?\\'" . w3m))
(use-package markdown-preview-eww
  :defer t)
;  :mode (".md" . markdown-preview-eww))
