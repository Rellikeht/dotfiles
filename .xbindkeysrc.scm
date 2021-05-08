;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;; any functions that work in guile will work here.
;; see EXTRA FUNCTIONS:

;; Version: 1.8.7

;; If you edit this file, do not forget to uncomment any lines
;; that you change.
;; The semicolon(;) symbol may be used anywhere for comments.

;; To specify a key, you can use 'xbindkeys --key' or
;; 'xbindkeys --multikey' and put one of the two lines in this file.

;; A list of keys is in /usr/include/X11/keysym.h and in
;; /usr/include/X11/keysymdef.h
;; The XK_ is not needed.

;; List of modifier:
;;   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
;;   Mod3 (CapsLock), Mod4, Mod5 (Scroll).


;; The release modifier is not a standard X modifier, but you can
;; use it if you want to catch release instead of press events

;; By defaults, xbindkeys does not pay attention to modifiers
;; NumLock, CapsLock and ScrollLock.
;; Uncomment the lines below if you want to use them.
;; To dissable them, call the functions with #f


;;;;EXTRA FUNCTIONS: Enable numlock, scrolllock or capslock usage
;;(set-numlock! #t)
;;(set-scrolllock! #t)
;;(set-capslock! #t)

;;;;; Scheme API reference
;;;;
;; Optional modifier state:
;; (set-numlock! #f or #t)
;; (set-scrolllock! #f or #t)
;; (set-capslock! #f or #t)
;; 
;; Shell command key:
;; (xbindkey key "foo-bar-command [args]")
;; (xbindkey '(modifier* key) "foo-bar-command [args]")
;; 
;; Scheme function key:
;; (xbindkey-function key function-name-or-lambda-function)
;; (xbindkey-function '(modifier* key) function-name-or-lambda-function)
;; 
;; Other functions:
;; (remove-xbindkey key)
;; (run-command "foo-bar-command [args]")
;; (grab-all-keys)
;; (ungrab-all-keys)
;; (remove-all-keys)
;; (debug)


;; Examples of commands:

;;(xbindkey '(control shift q) "xbindkeys_show")

;; set directly keycode (here control + f with my keyboard)
;;(xbindkey '("m:0x4" "c:41") "xterm")

;; specify a mouse button
;;(xbindkey '(control "b:2") "xterm")

;;(xbindkey '(shift mod2 alt s) "xterm -geom 50x20+20+20")

;; set directly keycode (control+alt+mod2 + f with my keyboard)
;;(xbindkey '(alt "m:4" mod2 "c:0x29") "xterm")

;; Control+Shift+a  release event starts rxvt
;;(xbindkey '(release control shift a) "rxvt")

;; Control + mouse button 2 release event starts rxvt
;;(xbindkey '(releace control "b:2") "rxvt")


;; Extra features
;;(xbindkey-function '(control a)
;;		   (lambda ()
;;		     (display "Hello from Scheme!")
;;		     (newline)))

;;(xbindkey-function '(shift p)
;;		   (lambda ()
;;		     (run-command "xterm")))


;; Double click test
;;(xbindkey-function '(control w)
;;		   (let ((count 0))
;;		     (lambda ()
;;		       (set! count (+ count 1))
;;		       (if (> count 1)
;;			   (begin
;;			    (set! count 0)
;;			    (run-command "xterm"))))))

;; Time double click test:
;;  - short double click -> run an xterm
;;  - long  double click -> run an rxvt
;;(xbindkey-function '(shift w)
;;		   (let ((time (current-time))
;;			 (count 0))
;;		     (lambda ()
;;		       (set! count (+ count 1))
;;		       (if (> count 1)
;;			   (begin
;;			    (if (< (- (current-time) time) 1)
;;				(run-command "xterm")
;;				(run-command "rxvt"))
;;			    (set! count 0)))
;;		       (set! time (current-time)))))
;;

;; Chording keys test: Start differents program if only one key is
;; pressed or another if two keys are pressed.
;; If key1 is pressed start cmd-k1
;; If key2 is pressed start cmd-k2
;; If both are pressed start cmd-k1-k2 or cmd-k2-k1 following the
;;   release order
;;(define (define-chord-keys key1 key2 cmd-k1 cmd-k2 cmd-k1-k2 cmd-k2-k1)
;;    "Define chording keys"
;;  (let ((k1 #f) (k2 #f))
;;    (xbindkey-function key1 (lambda () (set! k1 #t)))
;;    (xbindkey-function key2 (lambda () (set! k2 #t)))
;;    (xbindkey-function (cons 'release key1)
;;		       (lambda ()
;;			 (if (and k1 k2)
;;			     (run-command cmd-k1-k2)
;;			     (if k1 (run-command cmd-k1)))
;;			 (set! k1 #f) (set! k2 #f)))
;;    (xbindkey-function (cons 'release key2)
;;		       (lambda ()
;;			 (if (and k1 k2)
;;			     (run-command cmd-k2-k1)
;;			     (if k2 (run-command cmd-k2)))
;;			 (set! k1 #f) (set! k2 #f)))))
;;

;; Example:
;;   Shift + b:1                   start an xterm
;;   Shift + b:3                   start an rxvt
;;   Shift + b:1 then Shift + b:3  start gv
;;   Shift + b:3 then Shift + b:1  start xpdf

;;(define-chord-keys '(shift "b:1") '(shift "b:3")
;;  "xterm" "rxvt" "gv" "xpdf")

;; Here the release order have no importance
;; (the same program is started in both case)
;;(define-chord-keys '(alt "b:1") '(alt "b:3")
;;  "gv" "xpdf" "xterm" "xterm")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define pl "playerctl")
(define pacts (list " play-pause" " volume 0"
"d shift && playerctl -f \"{{xesam:title}}\" metadata | dzen2 -p 2"
" volume 0.02+" " volume 0.02-" " position 5+" " position 5-"))
(define macts (list " -G" " -v0"
" -i | awk \"BEGIN {FS=\\\"File: \\\"} /File:/ {print \\$2}\" | dzen2 -p 2"
" -v+3" " -v-3" " -f" " -r"))

(define pls (lambda (player) 
	(set! pl player)
	(run-command (string-append "echo " player " | dzen2 -p 1"))))

(define pla (lambda (player action)
	(if (string=? player "playerctl")
	(run-command (string-append player (list-ref pacts action)))
	(run-command (string-append player (list-ref macts action))))))

(define plc (lambda () (if (string=? pl "playerctl")
	(pls "mocp")
	(pls "playerctl"))))

(xbindkey-function '("XF86Tools") (lambda () (plc)))
;(xbindkey '("XF86Tools") "st -e mocp")

(xbindkey-function '("XF86AudioPlay") (lambda () (pla pl 0)))
(xbindkey-function '("XF86AudioMute") (lambda () (pla pl 1)))
(xbindkey-function '("XF86AudioStop") (lambda () (pla pl 2)))
(xbindkey-function '("XF86AudioRaiseVolume") (lambda () (pla pl 3)))
(xbindkey-function '("XF86AudioLowerVolume") (lambda () (pla pl 4)))
(xbindkey-function '("XF86AudioNext") (lambda () (pla pl 5)))
(xbindkey-function '("XF86AudioPrev") (lambda () (pla pl 6)))

;(xbindkey '("XF86AudioPlay") "playerctl play-pause")
;(xbindkey '("XF86AudioMute") "playerctl volume 0")
;(xbindkey '("XF86AudioStop") "playerctl stop")
;(xbindkey '("XF86AudioRaiseVolume") "playerctl volume 0.05+")
;(xbindkey '("XF86AudioLowerVolume") "playerctl volume 0.05-")
;(xbindkey '("XF86AudioNext") "playerctl next")
;(xbindkey '("XF86AudioPrev") "playerctl previous")

(xbindkey '("XF86Calculator") "xcas")
(xbindkey '("XF86HomePage") "tabbed st -w")
(xbindkey '("XF86Mail") "emacs")
(xbindkey '("XF86Explorer") "nvidia-settings")

(xbindkey '("Mod4" "Shift" "i") "xmodmap ~/.xmodmap/julka")

(define caps_mod 0)
(define caps_amod 0)
(define caps_mods (list "Escape" "Hyper_L"))
(define caps_amods (list "ISO_Level3_Shift" "ISO_Level3_Latch" "BackSpace"))
;"Control_L" 

(xbindkey-function '("m:0x40" "c:66") (lambda () 
	(set! caps_mod (modulo (+ caps_mod 1) (length caps_mods)))
	(run-command (string-append "xmodmap -e 'keycode 66 = " (list-ref caps_mods caps_mod) "'"))
	(run-command (string-append "echo " (list-ref caps_mods caps_mod) " | dzen2 -p 1"))))

(xbindkey-function '("m:0x41" "c:66") (lambda () 
	(set! caps_amod (modulo (+ caps_amod 1) (length caps_amods)))
	(run-command (string-append "xmodmap -e 'keycode 66 = " (list-ref caps_amods caps_amod) "'"))
	(run-command (string-append "echo " (list-ref caps_amods caps_amod) " | dzen2 -p 1"))))

