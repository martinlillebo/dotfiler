;;; radio-mode.el --- Numpad radio control -*- lexical-binding: t; -*-

(defun radio--kp-key (key)
  "Translate logical KEY (a single-char string) to its numpad keysym."
  (pcase key
    ("." "<kp-decimal>")
    ("," "<kp-decimal>")   ; Norsk numpad
    ("/" "<kp-divide>")
    ("*" "<kp-multiply>")
    ("+" "<kp-add>")
    ("-" "<kp-subtract>")
    (_   (format "<kp-%s>" key))))

(defvar radio-stations
  '(;; Page 0
    (("1" "NRK P1"          my/radio-nrk-p1)
     ("2" "NRK P2"          my/radio-nrk-p2)
     ("3" "NRK P3"          my/radio-nrk-p3)
     ("4" "NRK P13"         my/radio-nrk-p13)
     ("5" "NRK MP3"         my/radio-nrk-mp3)
     ("6" "NRK Klassisk"    my/radio-nrk-klassisk)
     ("7" "NRK Jazz"        my/radio-nrk-jazz)
     ("8" "ChilledCow"      my/radio-chilledcow)
     ("0" "Defcon"          my/radio-defcon)
     ("," "freeCodeCamp"    my/radio-freecodecamp)
     ("/" "Pays de Guéret"  my/radio-pays-de-gueret))
    ;; Page 1 — reach via `*'
    (("0" "Deutschlandfunk"         my/radio-deutschlandfunk)
     ("1" "WDR 1Live"               my/radio-wdr-1live)
     ("2" "laut.fm 100 DeutschPop"  my/radio-100-deutschpop)
     ("3" "RPR1 100% Deutsch-Pop"   my/radio-rpr1-deutschpop)))
  "Pages of stations. Each page is a list of (KEY LABEL COMMAND).
Page 0 is the default; press `*' (kp-multiply) once for page 1, twice
for page 2, etc.  Wraps around.")

(defvar radio--current-station nil
  "Label of the currently-playing station, or nil.")

(defvar radio--page 0
  "Current page index. Reset to 0 after every station selection.")

(defun radio--page-stations ()
  "Return the stations on the current page."
  (or (nth radio--page radio-stations)
      (car radio-stations)))

(defun radio-next-page ()
  "Advance to the next page; wraps to 0 after the last."
  (interactive)
  (setq radio--page (mod (1+ radio--page) (length radio-stations)))
  (radio--render))

(defun radio--dispatch (key)
  "Run the station bound to KEY on the current page; then reset page."
  (let ((entry (assoc key (radio--page-stations))))
    (cond
     (entry
      (call-interactively (nth 2 entry))
      (setq radio--current-station (nth 1 entry)))
     (t
      (message "No station on key %s (page %d)" key (1+ radio--page))))
    (setq radio--page 0)
    (radio--render)))

(defun radio--make-dispatcher (key)
  "Return an interactive command that dispatches KEY."
  (lambda () (interactive) (radio--dispatch key)))

(defvar radio-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "q")             #'quit-window)
    (define-key map (kbd "g")             #'radio-refresh)
    (define-key map (kbd "<kp-9>")        #'emms-stop)
    (define-key map (kbd "9")             #'emms-stop)
    (define-key map (kbd "<kp-add>")      #'emms-volume-raise)
    (define-key map (kbd "+")             #'emms-volume-raise)
    (define-key map (kbd "<kp-subtract>") #'emms-volume-lower)
    (define-key map (kbd "-")             #'emms-volume-lower)
    (define-key map (kbd "<kp-multiply>") #'radio-next-page)
    (define-key map (kbd "*")             #'radio-next-page)
    ;; Bind every key used on any page to the dispatcher.
    (let ((all-keys (delete-dups
                     (mapcar #'car (apply #'append radio-stations)))))
      (dolist (key all-keys)
        (let ((cmd (radio--make-dispatcher key)))
          (define-key map (kbd (radio--kp-key key)) cmd)
          (define-key map (kbd key)                 cmd))))
    map)
  "Keymap for `radio-mode'.")

(defun radio--render ()
  "Redraw the radio buffer from `radio-stations' and current state."
  (let ((inhibit-read-only t))
    (erase-buffer)
    (insert (propertize "Radio\n" 'face 'bold))
    (insert "=====\n\n")
    (when radio--current-station
      (insert (format "  Now playing: %s\n\n" radio--current-station)))
    (when (> (length radio-stations) 1)
      (insert (format "  Page %d/%d  (press * to cycle)\n\n"
                      (1+ radio--page) (length radio-stations))))
    (dolist (entry (radio--page-stations))
      (insert (format "  [%s]  %s\n" (nth 0 entry) (nth 1 entry))))
    (insert "\n")
    (insert "  [9] stop   [+/-] volume   [*] next page   [g] refresh   [q] quit\n")))

(defun radio-refresh ()
  "Re-render the radio buffer if it exists."
  (interactive)
  (when-let ((buf (get-buffer "*Radio*")))
    (with-current-buffer buf
      (when (derived-mode-p 'radio-mode)
        (radio--render)))))

(define-derived-mode radio-mode special-mode "Radio"
  "Major mode for controlling radio playback via numpad."
  (setq-local cursor-type nil)
  (setq-local radio--page 0)
  (radio--render))

(with-eval-after-load 'evil
  (evil-set-initial-state 'radio-mode 'emacs))

(defun radio ()
  "Open the radio control buffer."
  (interactive)
  (let ((buf (get-buffer-create "*Radio*")))
    (with-current-buffer buf
      (if (derived-mode-p 'radio-mode)
          (radio--render)
        (radio-mode)))
    (switch-to-buffer buf)))

(provide 'radio-mode)
