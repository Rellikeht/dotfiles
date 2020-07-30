(require 'package)
(setq package-archives
             '(("gnu" . "https://elpa.gnu.org/packages/")
	       ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(require 'undo-tree)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#000000" "#ff8059" "#44bc44" "#eecc00" "#33beff" "#feacd0" "#00d3d0" "#ffffff"])
 '(completion-auto-help (quote lazy))
 '(custom-enabled-themes (quote (abyss)))
 '(custom-safe-themes
   (quote
	("3d4df186126c347e002c8366d32016948068d2e9198c496093a96775cc3b3eaa" "8136cbb3b29b4c86ca3354d85005f527adcf9393b227980fc144a2c24ba63688" default)))
 '(dynamic-completion-mode t)
 '(elpy-syntax-check-command "pylint")
 '(enable-completion t)
 '(flymake-error-bitmap
   (quote
	(flymake-double-exclamation-mark modus-theme-fringe-red)))
 '(flymake-gui-warnings-enabled t)
 '(flymake-note-bitmap (quote (exclamation-mark modus-theme-fringe-cyan)))
 '(flymake-warning-bitmap (quote (exclamation-mark modus-theme-fringe-yellow)))
 '(hl-todo-keyword-faces
   (quote
	(("HOLD" . "#e5f040")
	 ("TODO" . "#feacd0")
	 ("NEXT" . "#b6a0ff")
	 ("THEM" . "#f78fe7")
	 ("PROG" . "#00d3d0")
	 ("OKAY" . "#4ae8fc")
	 ("DONT" . "#58dd13")
	 ("FAIL" . "#ff8059")
	 ("DONE" . "#44bc44")
	 ("NOTE" . "#f0ce43")
	 ("KLUDGE" . "#eecc00")
	 ("HACK" . "#eecc00")
	 ("TEMP" . "#ffcccc")
	 ("FIXME" . "#ff9977")
	 ("XXX+" . "#f4923b")
	 ("REVIEW" . "#6ae4b9")
	 ("DEPRECATED" . "#aaeeee"))))
 '(ibuffer-deletion-face (quote dired-flagged))
 '(ibuffer-filter-group-name-face (quote dired-mark))
 '(ibuffer-marked-face (quote dired-marked))
 '(ibuffer-title-face (quote dired-header))
 '(minibuffer-complete-cycle t nil (minibuffer-complete-cycle))
 '(package-selected-packages
   (quote
	(undo-tree ac-slime slime luarocks lua-mode flymake-lua dired-toggle-sudo direx dired-explorer cython-mode csproj-mode bf-mode apache-mode ztree abyss-theme python w3m elpy minibuffer-line minibuffer-complete-cycle chess vhdl-tools vector-utils all json-mode js2-mode svg verilog-mode modus-vivendi-theme)))
 '(python-flymake-command (quote ("pylint")))
 '(python-indent-guess-indent-offset t)
 '(python-indent-guess-indent-offset-verbose t)
 '(recentf-menu-open-all-flag t)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
	((20 . "#ff8059")
	 (40 . "#feacd0")
	 (60 . "#f78fe7")
	 (80 . "#f4923b")
	 (100 . "#eecc00")
	 (120 . "#e5f040")
	 (140 . "#f8dec0")
	 (160 . "#bfebe0")
	 (180 . "#44bc44")
	 (200 . "#58dd13")
	 (220 . "#6ae4b9")
	 (240 . "#4ae8fc")
	 (260 . "#00d3d0")
	 (280 . "#c6eaff")
	 (300 . "#33beff")
	 (320 . "#72a4ff")
	 (340 . "#00baf4")
	 (360 . "#b6a0ff"))))
 '(vc-annotate-very-old-color nil)
 '(xterm-color-names
   ["#000000" "#ff8059" "#44bc44" "#eecc00" "#33beff" "#feacd0" "#00d3d0" "#a8a8a8"])
 '(xterm-color-names-bright
   ["#181a20" "#f4923b" "#58dd13" "#e5f040" "#72a4ff" "#f78fe7" "#4ae8fc" "#ffffff"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'python-mode-hook
	    (lambda ()
		    (setq-default indent-tabs-mode t)
		    (setq-default tab-width 4)
		    (setq-default py-indent-tabs-mode t)
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(setq python-shell-interpreter "python")
(elpy-enable)
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
(define-key global-map (kbd "C-c o") 'iedit-mode)
(add-hook 'elpy-mode-hook
    (lambda ()
    (local-unset-key (kbd "M-TAB"))
    (define-key elpy-mode-map (kbd "C-d") 'elpy-company-backend)))

(recentf-mode 1)
(setq recentf-max-menu-items 9999)
(setq recentf-max-saved-items 9999)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil 60 'recentf-save-list)
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(global-display-line-numbers-mode)
(put 'scroll-left 'disabled nil)
(global-undo-tree-mode)
(put 'upcase-region 'disabled nil)
