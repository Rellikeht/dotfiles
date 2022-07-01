;; MODULES 
(use-modules (ice-9 ftw))
(use-modules (ice-9 popen))

(define klays (list-tail (scandir ".xmodmap") 2))
(define klay 0)

;; CONTROL OVER MULTIPLE PLAYERS USING MULTIMEDIA KEYS
;; playerctl
(define
  pacts
  (list
    " play-pause"
    (string-append
      " metadata --format "
      "\"Pos: {{duration(position)}} / {{duration(mpris:length)}}"
      "        |        Vol: {{volume*100}} %\" | dzen2 -p 2")
    "d shift && playerctl -f \"{{xesam:title}}\" metadata | dzen2 -p 2"
    " volume 0.02+ && playerctl volume | dzen2 -p 1"
    " volume 0.02- && playerctl volume | dzen2 -p 1"
    (string-append
      " position 5+ &&"
      "playerctl metadata --format \"{{duration(position)}}\" | "
      "dzen2 -p 1")
    (string-append
      " position 5- &&"
      "playerctl metadata --format \"{{duration(position)}}\" | "
      "dzen2 -p 1")))

;;TODO Reduce dzen spawning to use less cpu

;; mocp
(define
  macts
  (list
    " -G 2>/dev/null"
    (string-append
      " -i 2>/dev/null | "
      "grep -E '^CurrentTime|^TotalTime' | "
      "awk 'BEGIN {ORS=\" \";FS=\"[      ]|\\n\";"
      "RS=\"^$$\";OFS=\"\"}"
      "{print $4, \" / \", $2} END {print \"\\n\"}' | "
      "dzen2 -p 1")
    (string-append
      " -i 2>/dev/null | "
      "awk 'BEGIN {FS=\"File: \"} /File:/ {print $2}' | "
      "dzen2 -p 2")
    " -v+2 2>/dev/null"
    " -v-2 2>/dev/null"
    " -f 2>/dev/null"
    " -r 2>/dev/null"))

;; cmus (WIP)
;(define cats (list " -u"
;" -Q" something to get remaining time
;" -C \"format_print %F\""
;" -v+3%" " -v-3%"
;" -n" " -r"))

(define players
  (list (list "playerctl" pacts)
	(list "mocp" macts))) ;(list "cmus-remote")
(define pnum (length players))
(define pln 0)

(define pla
  (lambda (player action)
    (let
      ((alist (list-ref players player)))
      (run-command
	(string-append
	  (list-ref alist 0)
	  (list-ref
	    (list-ref alist 1)
	    action))))))

(define plc
  (lambda ()
    (set! pln
      (modulo (+ pln 1)
	      pnum))
    (run-command
      (string-append
	"echo "
	(list-ref
	  (list-ref players pln)
	  0)
	" | dzen2 -p 1"))))

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
(xbindkey
  '("XF86MonBrightnessUp")
  "doas brightnessctl s +5%
  sed -En '/Current brightness/s/.*\\(|\\)//gp' |
  dzen2 -p 2")
(xbindkey
  '("XF86MonBrightnessDown")
  "doas brightnessctl s 5%- |
  sed -En '/Current brightness/s/.*\\(|\\)//gp' |
  dzen2 -p 2")

(xbindkey-function
  '("XF86HomePage")
  (lambda ()
    (run-command
      (string-append
	"xmodmap .xmodmap/"
	(list-ref klays klay)))
    (run-command
      (string-append
	"echo "
	(list-ref klays klay)
	" | dzen2 -p 2"))
    (set! klay
      (modulo (+ klay 1)
	      (length klays)))
    (set! klays
      (list-tail
	(scandir ".xmodmap") 2))))


;; SOME MINOR BINDINGS

(xbindkey '("Mod4" "Shift" "i") "xmodmap ~/.xmodmap/julka")
(xbindkey '("Print") "shotgun")
(xbindkey '("Pause") "playerctl -a pause")
(xbindkey-function
  '("F2")
  (lambda ()
    (run-command
      "xdotool keyup F2 keydown ctrl key q keyup ctrl")))
;(xbindkey '("f36") "xdotool keydown control key x keyup control key @ h")
;(xbindkey '("f37") "xdotool keydown control key x keyup control key @ a")
;(xbindkey '("f38") "xdotool keydown control key x keyup control key @ c")
;(xbindkey '("f39") "xdotool keydown control key x keyup control key @ m")

;; MAPPING CAPS LOCK, GRAVE AND ESCAPE TO DIFFERENT KEYS

(define caps_mod 0)
(define caps_amod 0)
;(define caps_mods (list "Escape" "Hyper_L"))
;(define
;  caps_amods
;  (list
;    "ISO_Level3_Shift"
;    "ISO_Level3_Latch")) ;"Control_L" 

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
    (run-command
      (string-append
	"xmodmap -e 'keycode 9 = "  k0 "'"))
    (run-command
      (string-append
	"xmodmap -e 'keycode 49 = " k1 "'"))
    (run-command
      (string-append
	"xmodmap -e 'keycode 66 = " k2 "'"))
    (run-command
      (string-append
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

;; VOLUME CONTROL WITH SUPER + , AND SUPER + .

(define cardn 1)
(define sstep 1)
(define bstep 3)
(define cname "Master")

(xbindkey-function
  '("m:0x40" "c:59")
  (lambda ()
    (run-command
      (string-append
	"amixer -c "
	(number->string cardn)
	" -- sset "
	cname
	" "
	(number->string sstep)
	"db- | "
	(string-append
	  "grep --color=never dB | "
	  "cut -d ' ' -f6,7 | "
	  "sed -E 's/\\[|\\]//g' |"
	  "dzen2 -p 2")))))

(xbindkey-function
  '("m:0x40" "c:60")
  (lambda ()
    (run-command
      (string-append
	"amixer -c "
	(number->string cardn)
	" -- sset "
	cname
	" "
	(number->string sstep)
	"db+ | "
	(string-append
	  "grep --color=never dB | "
	  "cut -d ' ' -f6,7 | "
	  "sed -E 's/\\[|\\]//g' |"
	  "dzen2 -p 2")))))

(xbindkey-function
  '("m:0x41" "c:59")
  (lambda ()
    (run-command
      (string-append
	"amixer -c "
	(number->string cardn)
	" -- sset "
	cname
	" "
	(number->string bstep)
	"db- | "
	(string-append
	  "grep --color=never dB | "
	  "cut -d ' ' -f6,7 | "
	  "sed -E 's/\\[|\\]//g' |"
	  "dzen2 -p 2")))))

(xbindkey-function
  '("m:0x41" "c:60")
  (lambda ()
    (run-command
      (string-append
	"amixer -c "
	(number->string cardn)
	" -- sset "
	cname " "
	(number->string bstep)
	"db+ | "
	(string-append
	  "grep --color=never dB | "
	  "cut -d ' ' -f6,7 | "
	  "sed -E 's/\\[|\\]//g' |"
	  "dzen2 -p 2")))))


;;LOADING LOCAL CONFIG
(define local-config (string-append (getcwd) "/.xbindkeysrc.local.scm"))
(if (file-exists? local-config)
  (begin
    (load local-config)
    (display "Local config loaded\n"))
  (display "Local config not loaded\n"))
