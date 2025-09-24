;; MODULES 
(use-modules (ice-9 ftw))
(use-modules (ice-9 popen))

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

;(xbindkey '("XF86Calculator") "xcas")
(xbindkey '("XF86Mail") "emacs")
;(xbindkey '("XF86Explorer") "nvidia-settings")

(define os-name (vector-ref (uname) 0))
(define backlight-command ;; TODO proper case statement
  (if (equal? os-name "FreeBSD")
     (list
       "intel_backlight incr | awk '/set/ {print $4}' | dzen2 -p 1"
       "intel_backlight decr | awk '/set/ {print $4}' | dzen2 -p 1")

     (if (equal? os-name "Linux")
       (list
	 "doas brightnessctl s 5%+ |
	 sed -En '/Current brightness/s/.*\\(|\\)//gp' |
	 dzen2 -p 2"

	 "doas brightnessctl s 5%- |
	 sed -En '/Current brightness/s/.*\\(|\\)//gp' |
	 dzen2 -p 2")
       (list "" ""))))

(xbindkey '("XF86MonBrightnessUp") (car backlight-command))
(xbindkey '("XF86MonBrightnessDown") (cadr backlight-command))

;; SOME MINOR BINDINGS

(xbindkey '("Print") "cd ~/Downloads && shotgun")
(xbindkey '("Pause") "playerctl -a pause")

;;LOADING LOCAL CONFIG
(define local-config (string-append (getcwd) "/.xbindkeysrc.local.scm"))
(if (file-exists? local-config)
  (begin
    (load local-config)
    (display "Local config loaded\n"))
  (display "Local config not loaded\n"))
