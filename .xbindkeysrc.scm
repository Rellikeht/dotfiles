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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of xbindkeys default guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-modules (ice-9 ftw))
(use-modules (ice-9 popen))

(define klays (list-tail (scandir ".xmodmap") 2))
(define klay 0)

;; CONTROL OVER MULTIPLE PLAYERS USING MULTIMEDIA KEYS
;; playerctl
(define pacts (list " play-pause"

" metadata --format \"Pos: {{duration(position)}} / {{duration(mpris:length)}}        |        Vol: {{volume*100}} %\" | dzen2 -p 2"
"d shift && playerctl -f \"{{xesam:title}}\" metadata | dzen2 -p 2"

" volume 0.02+ && playerctl volume | dzen2 -p 1"
" volume 0.02- && playerctl volume | dzen2 -p 1"

" position 5+ &&
playerctl metadata --format \"{{duration(position)}}\" | dzen2 -p 1"

" position 5- &&
playerctl metadata --format \"{{duration(position)}}\" | dzen2 -p 1"
))

;;TODO Reduce dzen spawning to use less cpu

;; mocp
(define macts (list " -G 2>/dev/null"

" -i 2>/dev/null | grep -E \"^CurrentTime|^TotalTime\"

| awk \"BEGIN {ORS=\\\" \\\";FS=\\\"[      ]|\\n\\\";RS=\\\"^\\$$\\\";OFS=\\\"\\\"}
{print \\$4, \\\" / \\\", \\$2} END {print \\\"\\n\\\"}\" | dzen2 -p 1"

" -i 2>/dev/null | awk \"BEGIN {FS=\\\"File: \\\"} /File:/ {print \\$2}\" | dzen2 -p 2"

" -v+3 2>/dev/null" " -v-3 2>/dev/null"
" -f 2>/dev/null" " -r 2>/dev/null"))

;; cmus (WIP)
;(define cats (list " -u"
;" -Q" something to get remaining time
;" -C \"format_print %F\""
;" -v+3%" " -v-3%"
;" -n" " -r"))

(define players (list (list "playerctl" pacts) (list "mocp" macts))) ;(list "cmus-remote")
(define pnum (length players))
(define pln 0)

(define pla (lambda (player action)
	(let ((alist (list-ref players player)))
	(run-command (string-append (list-ref alist 0) (list-ref (list-ref alist 1) action))))))

(define plc (lambda ()
	(set! pln (modulo (+ pln 1) pnum))
	(run-command (string-append "echo " (list-ref (list-ref players pln) 0) " | dzen2 -p 1"))))

;; MAPPING MULTIMEDIA KEYS

(xbindkey-function '("XF86Tools") (lambda () (plc)))
(xbindkey-function '("XF86AudioPlay") (lambda () (pla pln 0)))
(xbindkey-function '("XF86AudioMute") (lambda () (pla pln 1)))
(xbindkey-function '("XF86AudioStop") (lambda () (pla pln 2)))
(xbindkey-function '("XF86AudioRaiseVolume") (lambda () (pla pln 3)))
(xbindkey-function '("XF86AudioLowerVolume") (lambda () (pla pln 4)))
(xbindkey-function '("XF86AudioNext") (lambda () (pla pln 5)))
(xbindkey-function '("XF86AudioPrev") (lambda () (pla pln 6)))
;; TODO add shift + keys

(xbindkey '("XF86Calculator") "xcas")
(xbindkey '("XF86Mail") "emacs")
(xbindkey '("XF86Explorer") "nvidia-settings")
(xbindkey '("XF86MonBrightnessUp") "doas brightnessctl s +5%")
(xbindkey '("XF86MonBrightnessDown") "doas brightnessctl s -5%")

(xbindkey-function '("XF86HomePage") (lambda ()
	(run-command (string-append "xmodmap .xmodmap/" (list-ref klays klay)))
	(run-command (string-append "echo " (list-ref klays klay) " | dzen2 -p 2"))
	(set! klay (modulo (+ klay 1) (length klays)))
	(set! klays (list-tail (scandir ".xmodmap") 2))))


;; SOME MINOR BINDINGS

(xbindkey '("Mod4" "Shift" "i") "xmodmap ~/.xmodmap/julka")
(xbindkey '("Print") "shotgun")
(xbindkey '("Pause") "playerctl -a pause")
(xbindkey-function '("F9") (lambda () (run-command "xdotool keyup F9 keydown ctrl key q keyup ctrl")))
;(xbindkey '("f36") "xdotool keydown control key x keyup control key @ h")
;(xbindkey '("f37") "xdotool keydown control key x keyup control key @ a")
;(xbindkey '("f38") "xdotool keydown control key x keyup control key @ c")
;(xbindkey '("f39") "xdotool keydown control key x keyup control key @ m")

;; MAPPING CAPS_LOCK TO DIFFERENT KEYS

(define caps_mod 0)
(define caps_amod 0)
;(define caps_mods (list "Escape" "Hyper_L"))
;(define caps_amods (list "ISO_Level3_Shift" "ISO_Level3_Latch")) ;"Control_L" 

(define wrt_keys
  '("Escape"
    "grave asciitilde grave asciitilde notsign logicalor notsign"
    "BackSpace"))

(define norm_keys
  (list (list-ref wrt_keys 1)
	"Hyper_L"
	(list-ref wrt_keys 0)))

(define emacs_keys
  (list (list-ref norm_keys 0)
	(list-ref norm_keys 2)
	(list-ref norm_keys 1)))

(define alt_keys (list-copy wrt_keys))
(list-set! alt_keys 2 "ISO_Level3_Shift") ;Latch

(define (ffield str)
  (list-ref (string-split str #\ ) 0))

(define (caps_mode keys)
  (let ((k0 (list-ref keys 0))
	(k1 (list-ref keys 1))
	(k2 (list-ref keys 2)))
    (run-command (string-append "xmodmap -e 'keycode 9 = "  k0 "'"))
    (run-command (string-append "xmodmap -e 'keycode 49 = " k1 "'"))
    (run-command (string-append "xmodmap -e 'keycode 66 = " k2 "'"))
    (run-command (string-append
		   "echo " (ffield k0)
		   " " (ffield k1)
		   " " (ffield k2)
		   " | dzen2 -p 1"))))

(xbindkey-function '("m:0x40" "c:66")
		   (lambda ()
		     (if (zero? caps_mod)
		       (caps_mode norm_keys)
		       (caps_mode emacs_keys))
		     (set! caps_mod (- 1 caps_mod))))

(xbindkey-function '("m:0x41" "c:66")
		   (lambda ()
		     (if (zero? caps_amod)
		       (caps_mode wrt_keys)
		       (caps_mode alt_keys))
		     (set! caps_amod (- 1 caps_amod))))

;(xbindkey-function '("m:0x40" "c:66") (lambda () 
;	(run-command (string-append "xmodmap -e 'keycode 9 = " (list-ref caps_mods caps_mod) "'"))
;	(set! caps_mod (- 1 caps_mod ))
;	(run-command (string-append "xmodmap -e 'keycode 66 = " (list-ref caps_mods caps_mod) "'"))
;	(run-command (string-append "echo " (list-ref caps_mods caps_mod) " | dzen2 -p 1"))))

;(xbindkey-function '("m:0x40" "c:66") (lambda () 
;	(set! caps_mod (modulo (+ caps_mod 1) (length caps_mods)))
;	(run-command (string-append "xmodmap -e 'keycode 66 = " (list-ref caps_mods caps_mod) "'"))
;	(run-command (string-append "echo " (list-ref caps_mods caps_mod) " | dzen2 -p 1"))))

;(xbindkey-function '("m:0x41" "c:66")
;		   (lambda () 
;		     (caps_mode norm_keys)
;		     (set! caps_amod (modulo (+ caps_amod 1) (length caps_amods)))
;		     (run-command (string-append "xmodmap -e 'keycode 66 = " (list-ref caps_amods caps_amod) "'"))
;		     (run-command (string-append "echo " (list-ref caps_amods caps_amod) " | dzen2 -p 1"))))


;; VOLUME CONTROL WITH SUPER + , AND SUPER + .

(define cardn 1)
(define sstep 1)
(define bstep 3)
(define cname "Master")

(xbindkey-function '("m:0x40" "c:59") (lambda ()
	(run-command (string-append "amixer -c " (number->string cardn) " -- sset " cname " " (number->string sstep) "db-"
	" | awk \"BEGIN {FS=\\\"[ 	\\\\\\[\\\\\\]]*\\\"} /dB/ {print \\$5, \\\"	\\\", \\$6}\" | dzen2 -p 1"))))

(xbindkey-function '("m:0x40" "c:60") (lambda () 
	(run-command (string-append "amixer -c " (number->string cardn) " -- sset " cname " " (number->string sstep) "db+"
	" | awk \"BEGIN {FS=\\\"[ 	\\\\\\[\\\\\\]]*\\\"} /dB/ {print \\$5, \\\"	\\\", \\$6}\" | dzen2 -p 1"))))


(xbindkey-function '("m:0x41" "c:59") (lambda ()
	(run-command (string-append "amixer -c " (number->string cardn) " -- sset " cname " " (number->string bstep) "db-"
	" | awk \"BEGIN {FS=\\\"[ 	\\\\\\[\\\\\\]]*\\\"} /dB/ {print \\$5, \\\"	\\\", \\$6}\" | dzen2 -p 1"))))

(xbindkey-function '("m:0x41" "c:60") (lambda () 
	(run-command (string-append "amixer -c " (number->string cardn) " -- sset " cname " " (number->string bstep) "db+"
	" | awk \"BEGIN {FS=\\\"[ 	\\\\\\[\\\\\\]]*\\\"} /dB/ {print \\$5, \\\"	\\\", \\$6}\" | dzen2 -p 1"))))


;; KEEPING STATIC MICROPHONE LEVEL
;;; Super + Ctrl + m
;(xbindkey '("m:0x44" "c:58") "~/.scrs/mic_stab_st.sh")

;;TODO arrows
;; Alt + Shift + h/j/k/l ?
;(xbindkey '("m:0x8" "c:43") "xdotool key Left")
;(xbindkey '("m:0x8" "c:44") "xdotool key Down")
;(xbindkey '("m:0x8" "c:45") "xdotool key Up")
;(xbindkey '("m:0x8" "c:46") "xdotool key Right")

;(xbindkey '("Alt" "Shift" "h") "xdotool key Left")
;(xbindkey '("Alt" "Shift" "j") "xdotool key Down")
;(xbindkey '("Alt" "Shift" "k") "xdotool key Up")
;(xbindkey '("Alt" "Shift" "l") "xdotool key Right")

;;TODO cursor movement?
;;TODO super latch?
;(define ss #t)
;(define sl #f)
;(define super_l '("c:135"))
;(define super_l '("m:0x40" "c:135"))
;(define super_l '("c:133"))
;(define super_l '("Mod4" "Super_L"))
;(define super_l '("Super_L"))
;(define super_l '("m:0x40" "c:133"))

;(define superlc "133")
;(define super_l (string-append "c:" superlc))
;(define super_switch "F20")

;(define sups (lambda ()
;	(if ss (run-command (string-append "xdotool keyup " super_switch " keydown " "Super_L"))
;		(run-command (string-append "xdotool keyup " super_switch " keyup " "Super_R")))
;	(set! ss (not ss)) (display "ss: ") (display ss) (newline)))

;(define sls (lambda ()
;	(run-command "xmodmap -pk | grep 133")
;	(if sl (lambda ()
;		(run-command (string-append "xmodmap -e \"keycode " superlc " = " super_switch "\""))
;		(usleep 80000)
;		(xbindkey-function super_switch sups))
;		(lambda () 
;		((remove-xbindkey super_switch)
;		(usleep 80000)
;		(run-coammand (string-append "xmodmap -e \"keycode " superlc " = Super_L" "\"")))))
;	(set! sl (not sl)) (display "sl: ") (display sl) (newline)))

; Mod4 + backslash
;(xbindkey-function '("m:0x40" "c:51") (lambda () (sls)))
;(run-command (string-append "xmodmap -e \"keycode " superlc " = " super_switch "\""))
;(run-command "xmodmap -pk | grep 133")
;(run-command (string-append "xmodmap -e \"remove mod4 = " superlc "\""))
;(usleep 100000)
;(xbindkey-function super_switch sups)
