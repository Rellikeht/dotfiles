;; ============================================================
;; PACKAGES AND FILES
;; ============================================================

(require 'package)
(setq package-archives
             '(("gnu" . "https://elpa.gnu.org/packages/")
	       ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Config files
(load (concat user-emacs-directory "my-functions.el"))
(load (concat user-emacs-directory "config.el"))
(load (concat user-emacs-directory "keys.el"))
(load (concat user-emacs-directory "editing.el"))
(load (concat user-emacs-directory "org.el"))
(load (concat user-emacs-directory "docs.el"))
(load (concat user-emacs-directory "lisp.el"))
(load (concat user-emacs-directory "markup.el"))
(load (concat user-emacs-directory "dev.el"))
(load (concat user-emacs-directory "terminals.el"))
(load (concat user-emacs-directory "files.el"))
(load (concat user-emacs-directory "math.el"))
(load (concat user-emacs-directory "local.el"))
;(load (concat user-emacs-directory "evil.el"))
;(condition-case
;   (load (concat user-emacs-directory "local.el"))
;  (error (message "local.el doesn't exist")))


;; ============================================================
;; SOME CUSTOM STUFF
;; ============================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#000000" "#ff8059" "#44bc44" "#eecc00" "#33beff" "#feacd0" "#00d3d0" "#ffffff"])
 '(completion-auto-help 'lazy)
 '(custom-enabled-themes '(wombat forest-blue))
 '(custom-safe-themes
   '("9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" "96c56bd2aab87fd92f2795df76c3582d762a88da5c0e54d30c71562b7bf9c605" "e7b7d1e49adc2b0533b4fe57617c358ecbca80f39d05a30b825b998fa86bc372" "3d4df186126c347e002c8366d32016948068d2e9198c496093a96775cc3b3eaa" "8136cbb3b29b4c86ca3354d85005f527adcf9393b227980fc144a2c24ba63688" default))
 '(dynamic-completion-mode t)
 '(elpy-syntax-check-command "pylint")
 '(enable-completion t)
 '(flymake-error-bitmap '(flymake-double-exclamation-mark modus-theme-fringe-red))
 '(flymake-gui-warnings-enabled t)
 '(flymake-note-bitmap '(exclamation-mark modus-theme-fringe-cyan))
 '(flymake-warning-bitmap '(exclamation-mark modus-theme-fringe-yellow))
 '(hl-todo-keyword-faces
   '(("HOLD" . "#e5f040")
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
     ("DEPRECATED" . "#aaeeee")))
 '(ibuffer-deletion-face 'dired-flagged)
 '(ibuffer-filter-group-name-face 'dired-mark)
 '(ibuffer-marked-face 'dired-marked)
 '(ibuffer-title-face 'dired-header)
 '(minibuffer-complete-cycle t nil (minibuffer-complete-cycle))
 '(mm-text-html-renderer 'w3m)
 '(org-load-hook '(org-bullets-mode))
 '(org-mode-hook
   '(org-tempo-setup
     #[0 "\305\306	>\203 \307
\310\311#\210\307\312\313#\210\307\314\315#\210\306	>\203, \307
\316\317#\210\307
\320\321#\210\322	>\203> \307\323\324#\210\307\325\324#\210\326	>\203P \307
\327\317#\210\307
\330\321#\210\331	>\203_ \332\311\333BC\334#\210\335	>\203k \332\311\336\334#\210\337	>\203w \332\311\340\334#\210\341\342\343\344\311$\210\345\342\311\"\210\342\207"
	 [org-mouse-context-menu-function org-mouse-features org-mouse-map org-mode-map org-outline-regexp org-mouse-context-menu context-menu org-defkey
					  [mouse-3]
					  nil
					  [mouse-3]
					  org-mouse-show-context-menu
					  [down-mouse-1]
					  org-mouse-down-mouse
					  [C-drag-mouse-1]
					  org-mouse-move-tree
					  [C-down-mouse-1]
					  org-mouse-move-tree-start yank-link
					  [S-mouse-2]
					  org-mouse-yank-link
					  [drag-mouse-3]
					  move-tree
					  [drag-mouse-3]
					  [down-mouse-3]
					  activate-stars font-lock-add-keywords
					  (0
					   `(face org-link mouse-face highlight keymap ,org-mouse-map)
					   'prepend)
					  t activate-bullets
					  (("^[ 	]*\\([-+*]\\|[0-9]+[.)]\\) +"
					    (1
					     `(face org-link keymap ,org-mouse-map mouse-face highlight)
					     'prepend)))
					  activate-checkboxes
					  (("^[ 	]*\\([-+*]\\|[0-9]+[.)]\\) +\\(\\[[ X]\\]\\)"
					    (2
					     `(face bold keymap ,org-mouse-map mouse-face highlight)
					     t)))
					  ad-add-advice org-open-at-point
					  (org-mouse-open-at-point nil t
								   (advice lambda nil
									   (let
									       ((context
										 (org-context)))
									     (cond
									      ((assq :headline-stars context)
									       (org-cycle))
									      ((assq :checkbox context)
									       (org-toggle-checkbox))
									      ((assq :item-bullet context)
									       (let
										   ((org-cycle-include-plain-lists t))
										 (org-cycle)))
									      ((org-footnote-at-reference-p)
									       nil)
									      (t ad-do-it)))))
					  around ad-activate]
	 5]
     #[0 "\300\301\302\303\304$\207"
	 [add-hook change-major-mode-hook org-show-all append local]
	 5]
     #[0 "\300\301\302\303\304$\207"
	 [add-hook change-major-mode-hook org-babel-show-result-all append local]
	 5]
     org-babel-result-hide-spec org-babel-hide-all-hashes org-bullets-mode))
 '(package-selected-packages
   '(linum-relative phi-search-mc use-package phi-search visual-regexp evil-args evil dante cdlatex org-beautify-theme org-bullets wgrep multi-vterm multi-term vterm markdown-preview-eww ob-browser ac-math ac-html eno mic-paren hlinum ccls auctex latex-math-preview latex-preview-pane forest-blue-theme slime-company undo-tree ac-slime slime dired-toggle-sudo direx dired-explorer cython-mode bf-mode apache-mode ztree python w3m elpy minibuffer-line minibuffer-complete-cycle chess vector-utils all json-mode js2-mode svg verilog-mode modus-vivendi-theme))
 '(python-flymake-command '("pylint"))
 '(python-indent-guess-indent-offset t)
 '(python-indent-guess-indent-offset-verbose t)
 '(recentf-menu-open-all-flag t)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#ff8059")
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
     (360 . "#b6a0ff")))
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
