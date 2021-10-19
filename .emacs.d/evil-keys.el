;;; bind evil-args text objects
;(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
;(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
;
;;; bind evil-forward/backward-args
;(define-key evil-normal-state-map "L" 'evil-forward-arg)
;(define-key evil-normal-state-map "H" 'evil-backward-arg)
;(define-key evil-motion-state-map "L" 'evil-forward-arg)
;(define-key evil-motion-state-map "H" 'evil-backward-arg)
;
;;; bind evil-jump-out-args
;(define-key evil-normal-state-map "K" 'evil-jump-out-args)

(global-unset-key (kbd "C-u"))
(global-set-key (kbd "C-u") 'evil-scroll-up)
