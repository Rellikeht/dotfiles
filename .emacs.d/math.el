(use-package maxima
;    :init
;  (add-hook 'maxima-mode-hook #'maxima-hook-function)
;  (add-hook 'maxima-inferior-mode-hook #'maxima-hook-function)
;  (setq
;   org-format-latex-options (plist-put org-format-latex-options :scale 2.0)
;   maxima-display-maxima-buffer nil)
    :mode ("\\.mac\\'" . maxima-mode)
    :interpreter ("maxima" . maxima-mode))

(defun maxima-init ()
  (interactive)
  (switch-to-buffer "*maxima-init*")
  (maxima-mode)
  (maxima)
  (kill-buffer "*maxima-init*"))
 
(use-package company-maxima
    :disabled t
    :defer t)
