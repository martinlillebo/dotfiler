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
  '(("1" "NRK P1"          my/radio-nrk-p1)
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
  "Stations: (KEY LABEL COMMAND).
KEY is the logical numpad key; the numpad keysym is derived via
`radio--kp-key'.  For digits, the plain key is also bound to shadow
`special-mode-map''s `digit-argument'.")

(defvar radio--current-station nil
  "Label of the currently-playing station, or nil.
Placeholder for the upcoming now-playing display.")

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
    (dolist (entry radio-stations)
  (let* ((key (nth 0 entry))
         (cmd (nth 2 entry)))
    (define-key map (kbd (radio--kp-key key)) cmd)
    (define-key map (kbd key)                 cmd)))
    map)
  "Keymap for `radio-mode'. Built from `radio-stations'.")

(defun radio--render ()
  "Redraw the radio buffer from `radio-stations' and current state."
  (let ((inhibit-read-only t))
    (erase-buffer)
    (insert (propertize "Radio\n" 'face 'bold))
    (insert "=====\n\n")
    (when radio--current-station
      (insert (format "  Now playing: %s\n\n" radio--current-station)))
    (dolist (entry radio-stations)
      (insert (format "  [%s]  %s\n" (nth 0 entry) (nth 1 entry))))
    (insert "\n")
    (insert "  [9] stop   [+/-] volume   [g] refresh   [q] quit\n")))

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
