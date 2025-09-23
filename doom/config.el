;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hei, ikke endre denne filen direkte - den veves ut fra literalfilen ~emacs-config.org~ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'kanagawa-wave)

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq catppuccin-flavor 'macchiato)

(add-hook 'server-after-make-frame-hook
          (lambda () (when (fboundp 'catppuccin-reload)
                       (catppuccin-reload))))

(when (fboundp 'catppuccin-reload)
  (catppuccin-reload))

(custom-set-faces!
  ;;'(line-number-current-line :weight bold :foreground "#cdd6f4")  ;; Current line number
  '(line-number              :foreground "#b8c2dc"))               ;; Other line numbers

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)

(setq fancy-splash-image "~/repos/dotfiler/doom/emacs.png")

(setq doom-font (font-spec :family "FantasqueSansMNerdFontMono" :size 14))

(setq frame-title-format '("%b"))

(setq confirm-kill-emacs nil)

(setq-default lexical-binding t)

(setq initial-major-mode 'lisp-interaction-mode)

(setq +scratch-default-mode 'lisp-interaction-mode)

(setq auto-save-visited-interval 5)
(auto-save-visited-mode +1)

(map! :leader
      :desc "New dated org file"
      "- RET" #'my/datert-orgfil)

(map! :leader
      :desc "Dirvish quick access"
      "RET" #'dirvish-quick-access)

(setq display-line-numbers-type 'relative)

(setq bookmark-save-flag 1)

;; (setq browse-url-firefox-program "explorer.exe")

;; (setq browse-url-firefox-program nil)

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "explorer.exe")

(setq org-ellipsis " ...")

(set-frame-parameter (selected-frame) 'alpha '(94 . 94))
(add-to-list 'default-frame-alist '(alpha . (94 . 94)))

(nyan-mode 1)

(after! org
  (add-hook 'org-mode-hook #'rainbow-mode))

(after! vimgolf
  (map! :leader
        ;; call vimgolf prompt
        "g v" #'vimgolf
        ;; default bindings as listed in README
        "g V" #'vimgolf-submit))

(after! projectile
  (dolist (p '("~/repos/notater"
               "~/repos/ansible-desktop"))
    (projectile-add-known-project p)))

;;(evil-escape-mode -1)

(require 'key-chord)
(key-chord-mode 1)
;; (key-chord-define evil-insert-state-map "oi" 'evil-normal-state)
;; (key-chord-define evil-visual-state-map "oi" 'evil-normal-state)
(setq key-chord-two-keys-delay 0.2)

;; (after! evil
;;     (define-key evil-insert-state-map (kbd "<escape>") 'ignore)
;;     (define-key evil-visual-state-map (kbd "<escape>") 'ignore))

(after! org
  (setq org-todo-keyword-faces
        '(;;("TODO" . (:foreground "#ffff00" :weight bold))
          ("STRT" . (:foreground "#ffff00" :weight bold))
          ("KILL" . (:foreground "#595e60" :weight bold))
          ("WAIT" . (:foreground "#B4F8C8" :weight bold))
          ("PROJ" . (:foreground "#B4F8C8" :weight bold))
          ;;("DONE" . (:foreground "forest green" :weight bold))
          )))

(setq org-log-done 'time)

(defun my/datert-orgfil (title)
  "Create a new Org file with format YYYYMMDDMM Title.org in ~/repos/notater/."
  (interactive "sTitle: ")
  (let* ((timestamp (format-time-string "%Y%m%d%H%M"))
         (filename (format "~/repos/notater/%s %s.org" timestamp title)))
    (find-file filename)))

(setq org-directory (expand-file-name "~/repos/notater/"))

(setq org-roam-directory org-directory)
(after! org-roam
  (org-roam-db-autosync-mode))

(after! org
  (setq org-capture-templates
        '(("3" "Jobb innboks - TODO" entry
           (file "~/repos/notater/202111121500 Innboks jobb.org")
           "* TODO %?\n%U\n" :prepend t)

          ("4" "Jobb innboks" entry
           (file "~/repos/notater/202111121500 Innboks jobb.org")
           "* %?\n%U\n" :prepend t)

          ("1" "Privat innboks - TODO" entry
           (file "~/repos/notater/202012111337 Innboks.org")
           "* TODO %?\n%U\n" :prepend t)

          ("2" "Privat innboks" entry
           (file "~/repos/notater/202012111337 Innboks.org")
           "* %?\n%U\n" :prepend t))))

(setq org-export-with-todo-keywords t)

(setq org-refile-targets
      '(("~/repos/notater/202111121500 Innboks jobb.org" :maxlevel . 1)
        ("~/repos/notater/202012111337 Innboks.org" :level . 1)))

(add-load-path! "~/.config/doom/lokal")

(after! org
  (require 'ob-ansible)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ansible . t)  ; enables org-babel-execute:ansible 😊
     ;; …other languages you already have…
     )))

(defun my/org-export-to-tmp-html ()
  (interactive)
  (let* ((basename (file-name-base (or (buffer-file-name) (buffer-name))))
         (outfile (concat "/tmp/" basename ".html")))
    ;; export the Org buffer to /tmp/basename.html
    (org-export-to-file 'html outfile nil nil nil nil nil)
    ;; open it in Firefox in a new tab
    (start-process "firefox-preview" nil "/usr/bin/firefox" "--new-tab" outfile)))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode))

(setq writeroom-width 50)

(setq embark-prompter 'embark-completing-read-prompter)

(defun my/open-gmail-firefox-tab ()
  "Åpner Gmail som ny tab i Firefox"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://mail.google.com/mail/u/0/#inbox"))

(defun my/open-outlook-firefox-tab ()
  "Åpner Outlook som ny tab i Firefox"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://outlook.office.com/mail/"))

(defun my/yr-lillebo ()
  "Værmelding for Lillebo"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://www.yr.no/nb/v%C3%A6rvarsel/daglig-tabell/1-174419/Norge/Innlandet/Engerdal/Lillebo"))

(defun my/yr-innbygda ()
  "Værmelding for Innbygda"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://www.yr.no/nb/v%C3%A6rvarsel/daglig-tabell/1-157692/Norge/Innlandet/Trysil/Innbygda"))

(defun my/yr-oslo-christies ()
  "Værmelding for Oslo"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://www.yr.no/nb/v%C3%A6rvarsel/daglig-tabell/10-995776/Norge/Oslo/Oslo/Christies%20gate"))

(defun my/open-google-kalender-firefox-tab ()
  "Åpner Google Calendar som ny tab i Firefox"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://calendar.google.com/"))

(defun my/open-outlook-kalender-firefox-tab ()
  "Åpner Outlook Calendar som ny tab i Firefox"
  (interactive)
  (start-process
   "firefox" nil
   "/usr/bin/firefox" "--new-tab" "https://outlook.office.com/calendar/view/week"))

(defun my/tidsstempel-sekund ()
  (interactive)
  "Returnerer tidsstempel som YYYY-MM-DD TT:MM:SS"
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

(defun my/tidsstempel-dato ()
  (interactive)
  "Returnerer tidsstempel som YYYY-MM-DD"
  (insert (format-time-string "%Y-%m-%d")))

(map! "<S-delete>" #'my/tidsstempel-dato)
(map! "<C-S-delete>" #'my/tidsstempel-sekund)

(after! dirvish
  (setq dirvish-quick-access-entries
        '(("e" "~/repos/notater/2025060337 emacs-config.org"                   "emacs-config")
          ("d" "~/repos/notater/2025060333 Doom Emacs - Læring.org"            "Emacs Doom - Læring")
          ("a" "~/repos/notater/202012010931 Arbeidsoppgaver.org"              "Arbeidsoppgaver")
          ("c" "~/repos/notater/20250922135432-statnett_oversikt.org"              "Statnett")
          ("." "/home/ml/repos/dotfiler"                                       "dotfiler")
          ("f" "~/repos/notater/org/20250531191654-todo_familie.org"           "Todo familie")
          ("t" "~/repos/notater/202506120825 Todo.org"                         "Todo privat")
          ("s" "~/repos/notater/org/20250730110754-sopra_steria_oversikt.org"  "Sopra Steria")
          ("n" "~/repos/notater/202011200904 Dagnotater.md"                      "Dagnotater")
          ("i" "~/repos/notater/202012111337 Innboks.org"                      "Innboks")
          ("o" "~/repos/notater/202111121500 Innboks jobb.org"                 "Innboks jobb")
          ("p" "~/repos/notater/202008161252 Pakkeliste.org"                 "Pakkelista")
          ("b" "~/repos/notater/20200906130506 Bøker jeg kanskje vil lese.org" "Bøker - Kanskje lese")
          ;; Add more entries as desired
          )))

(map! :leader
      (:prefix ("o" . "open")
       :desc "Open Dirvish (alias SPC o /)" "o" #'dirvish))

(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 0))

;; (setq initial-buffer-choice "~/repos/notater/2025060408 doom-startside.org")

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Stopp EMMS-radio" "s" #'emms-stop))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-defcon ()
    "Spiller av DEF CON Radio"
    (interactive)
    (emms-play-url "http://ice3.somafm.com/defcon-128-mp3")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av DEF CON radio" "d" #'my/radio-defcon))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-jazz ()
    "Spiller av NRK Jazz"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/jazz_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av NRK Jazz" "j" #'my/radio-nrk-jazz))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-klassisk ()
    "Spiller av NRK Klassisk"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/klassisk_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av NRK Klassisk" "k" #'my/radio-nrk-klassisk))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p1 ()
    "Spiller av NRK P1"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p1_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av " "1" #'my/radio-nrk-p1))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p2 ()
    "Spiller av NRK P2"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p2_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av NRK P2" "2" #'my/radio-nrk-p2))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p3 ()
    "Spiller av NRK P3"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p3_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av nrk P3" "3" #'my/radio-nrk-p3))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p13 ()
    "Spiller av NRK P13"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p13_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av " "t" #'my/radio-nrk-p13))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-mp3 ()
    "Spiller av NRK mP3"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/mp3_mp3_h")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av NRK mP3" "m" #'my/radio-nrk-mp3))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-freecodecamp ()
    "Spiller av freeCodeCamp sin nettradio"
    (interactive)
    (emms-play-url "https://coderadio-admin-v2.freecodecamp.org/listen/coderadio/radio.mp3")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av radio FreeCodeCamp" "f" #'my/radio-freecodecamp))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-rainwave ()
    "Spiller av Rainwave.cc sin nettradio - Videospillmusikk"
    (interactive)
    (emms-play-url "https://relay.rainwave.cc/all.mp3")))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Spill av Rainwave-radio" "r" #'my/radio-rainwave))

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

(after! org-present
  (setq org-present-level 99))  ;; 2 = * and ** are slides

;; defun (my/åpne-config
;;   (interactive)
;;        )

(defun my/org-insert-subheading ()
  "Insert a new subheading below, position cursor after a space, ready for input."
  (interactive)
  (org-insert-heading)
  (org-metaright)
  (end-of-line)                 ;; go to end of heading stars
  (insert " ")                  ;; add a space
  (evil-insert-state))          ;; switch to insert mode

(defun my/convert-md-header-to-org ()
  "Convert flexible ZK-style .md file to Org-roam-compatible .org file and rename it."
  (interactive)
  (when (string-match "\\.md$" buffer-file-name)
    (save-excursion
      (goto-char (point-min))

      ;; Title line: "# <!-- TIMESTAMP --> Title" OR "# TIMESTAMP Title"
      (when (looking-at "^# *\\(?:<!-- *\\([0-9]+\\) *-->\\|\\([0-9]+\\)\\) *\\(.*\\)")
        (let ((title (match-string 3)))
          (replace-match (format "#+title: %s" title) t t)))

      ;; Tags line: replace full line
      (goto-char (point-min))
      (when (re-search-forward "^<!-- *tags: *\\(.*?\\) *-->" nil t)
        (let* ((raw-tags (match-string 1))
               (tags (mapconcat
                      (lambda (tag)
                        (concat ":" (string-trim-left (replace-regexp-in-string "^#" "" tag)) ":"))
                      (split-string raw-tags) "")))
          (replace-match (format "#+filetags: %s" tags) nil nil)))

      ;; Backlink line: plain or commented
      (goto-char (point-min))
      (when (re-search-forward "^\\(?:<!-- *\\)?\\(Fra\\|Opprettet fra\\): *\\(\\[\\[.*?\\]\\] .*\\)\\(?: *-->\\)?$" nil t)
        (replace-match (format "#+ROAM_REFS: %s" (match-string 2)) t t)))

    ;; Normalize "## Ref", "## Kilder", etc.
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^\\(?:## *\\)?\\(ref\\|Ref\\|kilder\\|Kilder\\)\\s-*$" nil t)
        (replace-match "* ref")))

    ;; Insert :ID: property if not already present
    (save-excursion
      (goto-char (point-min))
      (unless (re-search-forward "^:PROPERTIES:" nil t)
        (let ((uuid (org-id-uuid)))
          (forward-line)
          (insert ":PROPERTIES:\n:ID: " uuid "\n:END:\n\n"))))

    ;; Rename file
    (let ((new-name (concat (file-name-sans-extension buffer-file-name) ".org")))
      (when (file-exists-p new-name)
        (delete-file new-name))
      (rename-visited-file new-name)
      (message "Converted and renamed to: %s" new-name))))

(defvar my/emoji-numpad-map
  '((7 . "📁") (2 . "🍺") (6 . "👍") (5 . "🌞"))
  "Mapping from numbers to emojis for `my/emoji-numpad'.")

(defun my/emoji-numpad ()
  "Prompt for a number; insert mapped emoji, else say 'undefined' in echo area."
  (interactive)
  (let* ((n (read-number "Enter a number: "))
         (emoji (alist-get n my/emoji-numpad-map)))
    (if emoji
        (insert emoji)
      (message "undefined"))))
