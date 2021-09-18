
;; Permit kill-saving text to and from to X11 clipboard; beats the
;; heck out of manually copying with the cursor.
(defun kill-save-to-x-clipboard ()
  (interactive)
  (progn
    (shell-command-on-region (region-beginning) (region-end) "xclip -i")
    (message "Kill-saved region to clipboard!")
    (deactivate-mark)))

(defun yank-from-x-clipboard ()
  (interactive)
  (progn
    (insert (shell-command-to-string "xclip -o")))
    (message "Yanked region from clipboard!"))


(defun refresh-svg-preview ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (with-current-buffer (get-buffer-create "*svg-preview*")
      (fundamental-mode)
      (erase-buffer)
      (insert-buffer-substring oldbuf)
      (image-mode))))


(defun async-run (command)
  (interactive "aFunction name: ")
;  (message command))
;  (run-with-idle-timer 0 nil command))
  (run-with-idle-timer 0 nil (call-interactively command)))

(cl-defun async-run-bg-buffer (command &optional (name "command"))
  (interactive "aFunction name: ")
  (make-thread (lambda () (let curbuf (current-buffer) (switch-to-buffer name) (insert (apply command)) (switch-to-buffer curbuf)))))

(defun eval-sexp (sexp)
  (interactive "xSexp: ")
  (eval sexp))

(defun async-run-sexp (sexp)
  (interactive "xSexp: ")
  (make-thread (lambda () (let curbuf (current-buffer) (switch-to-buffer name) (insert (eval sexp)) (switch-to-buffer curbuf)))))

(defun backward-other-window ()
  (interactive)
  (other-window -1))
