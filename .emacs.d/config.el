;; Packages
(use-package forest-blue-theme)

;; Disable linum in doc view mode
(add-hook 'doc-view-mode-hook
	  (lambda ()
	    (add-hook 'after-change-major-mode-hook
		      (lambda ()
			(linum-mode 0))
		      :append :local)))

;; Recentf things
(run-at-time nil 60 'recentf-save-list)
(recentf-mode 1)
(setq-default recentf-max-menu-items 9999)
(setq-default recentf-max-saved-items 9999)

;; Some useful options
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq-default scroll-conservatively 10000)
(put 'list-timers 'disabled nil)
(setq-default tab-always-indent 'complete)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
