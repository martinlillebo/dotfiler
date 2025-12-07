;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hei, ikke endre denne filen direkte - den veves ut fra literalfilen ~emacs-config.org~ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'kanagawa-wave)

;; (setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq catppuccin-flavor 'macchiato)

(add-hook 'server-after-make-frame-hook
          (lambda () (when (fboundp 'catppuccin-reload)
                       (catppuccin-reload))))

(when (fboundp 'catppuccin-reload)
  (catppuccin-reload))

(setq doom-theme 'catppuccin)

(custom-set-faces!
  ;;'(line-number-current-line :weight bold :foreground "#cdd6f4")  ;; Current line number
  '(line-number              :foreground "#b8c2dc"))               ;; Other line numbers

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)

(setq fancy-splash-image "~/repos/dotfiler/doom/emacs.png")

(cond
 ;; ---  WSL  ---
 ((and (eq system-type 'gnu/linux) (getenv "WSLENV"))
  (add-to-list 'initial-frame-alist '(width . 90))
  (add-to-list 'initial-frame-alist '(height . 60)))

 ;; --- Linux ---
 ((eq system-type 'gnu/linux)
  (add-to-list 'initial-frame-alist '(width . 83))
  (add-to-list 'initial-frame-alist '(height . 44))))

(setq kill-ring-max 1000)

;(setq word-wrap nil)
(add-hook 'doom-after-init-modules-hook
  (lambda () (setq-default word-wrap nil)))

(setq-default truncate-lines nil)

(when (find-font (font-spec :family "FantasqueSansMNerdFontMono"))
  (setq doom-font (font-spec :family "FantasqueSansMNerdFontMono" :size 14)))

(setq user-full-name "Martin Lillebo"
      user-mail-address "lillebomartin@gmail.com")

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

(map! "C-s" #'save-buffer)'

(map! :i "C-s" #'save-buffer   ; insert mode
      :n "C-s" #'save-buffer)  ; normal mode

(setq display-line-numbers-type 'visual)

(setq bookmark-save-flag 1)

(setq org-ellipsis " ...")

(with-eval-after-load 'pixel-scroll
  (defalias 'pixel-scroll-interpolate-down 'ignore)
  (defalias 'pixel-scroll-interpolate-up 'ignore))

(map! :leader
      "y k" #'yank-from-kill-ring)

(define-key evil-normal-state-map (kbd "SPC v s")
  (lambda () (interactive)
    (execute-kbd-macro (kbd "v i W S ~"))
    (evil-forward-WORD-end)))

(define-key evil-visual-state-map (kbd "SPC v s")
  (lambda () (interactive)
    (let ((end-pos (region-end)))
      (execute-kbd-macro (kbd "S ~"))
      (goto-char (+ end-pos 1)))))

(setq garbage-collection-messages t)

(setq show-smartparens-global-mode t)

(after! browse-url
  ;; Default to Firefox everywhere
  (setq browse-url-browser-function 'browse-url-generic)

  (cond
   ;; WSLENV fins bare på WSL, altså Windows
   ((and (eq system-type 'gnu/linux)
         (getenv "WSLENV"))
    (setq browse-url-generic-program "cmd.exe"
          browse-url-generic-args '("/c" "start" "")))

   ;; --- Linux ---
   ((eq system-type 'gnu/linux)
    (setq browse-url-generic-program "firefox"))

   ;; Android
   ((eq system-type 'android)
    (setq browse-url-generic-program "xdg-open"))))

(when (eq system-type 'android)
    (add-hook 'help-mode-hook #'visual-line-mode))

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

(setq keyfreq-excluded-commands
        '(mwheel-scroll
          ultra-scroll
          self-insert-command
          org-self-insert-command))

(setq keyfreq-autosave-timeout 180)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(after! projectile
  (dolist (p '("~/repos/notater"
               "~/repos/ansible-desktop"))
    (projectile-add-known-project p)))

(setq projectile-indexing-method 'alien)

(after! projectile
  (defun my/rename-file-invalidate-projectile-cache (&rest _)
      (when (and (called-interactively-p 'any)
                       (featurep 'projectile))
                                     (projectile-invalidate-cache nil)))

  (advice-add 'rename-file :after #'my/rename-file-invalidate-projectile-cache))

(use-package better-jumper

    :custom
    ; this is the key to avoiding conflict with evils jumping stuff
    (better-jumper-use-evil-jump-advice nil)

    :config
    (better-jumper-mode 1)

    ; this lets me toggle between two points. (adapted from evil-jump-backward-swap)
    (evil-define-motion better-jumper-toggle (count)
      (let ((pnt (point)))
        (better-jumper-jump-backward 1)
        (better-jumper-set-jump pnt)))

    ; this is the key here. This advice makes it so you only set a jump point
    ; if you move more than one line with whatever command you call. For example
    ; if you add this advice around evil-next-line, you will set a jump point
    ; if you do 10 j, but not if you just hit j. I did not write this code, I
    ; I found it a while back and updated it to work with better-jumper.
    (defun my-jump-advice (oldfun &rest args)
      (let ((old-pos (point)))
        (apply oldfun args)
        (when (> (abs (- (line-number-at-pos old-pos) (line-number-at-pos (point))))
                  1)
          (better-jumper-set-jump old-pos))))

    ; jump scenarios
    (advice-add 'evil-next-line :around #'my-jump-advice)
    (advice-add 'evil-previous-line :around #'my-jump-advice)
    (advice-add 'helm-swoop :around #'my-jump-advice)
    (advice-add 'evil-goto-definition :around #'my-jump-advice)
    (advice-add 'evil-goto-mark  :around #'my-jump-advice))
    ; ... whenever you want a new jump scenario just use the above pattern.

;;(evil-escape-mode -1)

(require 'key-chord)
(key-chord-mode 1)
;; (key-chord-define evil-insert-state-map "oi" 'evil-normal-state)
;; (key-chord-define evil-visual-state-map "oi" 'evil-normal-state)
(setq key-chord-two-keys-delay 0.2)

;; (after! evil
;;     (define-key evil-insert-state-map (kbd "<escape>") 'ignore)
;;     (define-key evil-visual-state-map (kbd "<escape>") 'ignore))

(setq org-cycle-separator-lines 0)

;(add-hook 'org-mode-hook
;   (lambda ()
;     (visual-line-mode -1)
;     (toggle-word-wrap 1)))

(after! org
  (setq org-todo-keyword-faces
        '(;;("TODO" . (:foreground "#ffff00" :weight bold))
          ("STRT" . (:foreground "#ffff00" :weight bold))
          ("KILL" . (:foreground "#595e60" :weight bold))
          ("WAIT" . (:foreground "#B4F8C8" :weight bold))
          ("HOLD" . (:foreground "#B4F8C8" :weight bold))
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
        '(

          ("1" "Innboks" entry
           (file "~/repos/notater/202012111337 Innboks.org")
           "%?\n" :prepend t))))

(setq org-export-with-todo-keywords t)

(setq org-element-use-cache nil)

(setq org-agenda-remove-tags t)

(setq org-agenda-prefix-format
      '((agenda . "")
        (todo . "")
        (tags . "")
        (search . "")))

(setq org-agenda-overriding-header " ")

(setq org-agenda-custom-commands
      '(("j" "Jobb-sprint" tags-todo "sprint")))

(defun my/skip-if-parent-has-tag (tag)
  "Skip entry if any ancestor has TAG."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (save-excursion
          (while (and (org-up-heading-safe)
                      (not (member tag (org-get-tags)))))
          (member tag (org-get-tags)))
        subtree-end
      nil)))

(setq org-agenda-custom-commands
      '(("j" "Jobb-sprint" tags-todo "sprint"
         ((org-agenda-skip-function '(my/skip-if-parent-has-tag "sprint"))))))

(setq org-agenda-dim-blocked-tasks nil)

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
  (let ((outfile (concat "/tmp/"
                         (file-name-base (or (buffer-file-name)
                                             (buffer-name)))
                         ".html")))
    (org-export-to-file 'html outfile nil nil nil nil nil)
    (browse-url (if (and (eq system-type 'gnu/linux)
                         (getenv "WSLENV"))
                    (concat "\\\\wsl.localhost\\Ubuntu" outfile)
                  outfile))))

(defun my/org-eksport-til-pdf ()
  "Export subtree using headline as title and open in browser."
  (interactive)
  (org-back-to-heading t)
  (let* ((title (nth 4 (org-heading-components)))
         (pdf-file (progn
                     (org-set-property "EXPORT_TITLE" title)
                     (org-latex-export-to-pdf nil t))))
    (when pdf-file
      (browse-url pdf-file))))

(run-with-idle-timer 30 t
  (lambda ()
      (when (evil-insert-state-p)
            (evil-normal-state))))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode))

(setq writeroom-width 50)

(setq embark-prompter 'embark-completing-read-prompter)

(defun my/open-gmail-firefox-tab ()
  "Åpner Gmail som ny tab i Firefox"
  (interactive)
  (browse-url
   "https://mail.google.com/mail/u/0/#inbox"))

(defun my/open-outlook-firefox-tab ()
  "Åpner Outlook som ny tab i Firefox"
  (interactive)
  (browse-url "https://outlook.office.com/mail/"))

(defun my/yr-lillebo ()
  "Open the weather forecast for Lillebo in the system’s default browser."
  (interactive)
  (browse-url
  "https://www.yr.no/nb/v%C3%A6rvarsel/daglig-tabell/1-174419/Norge/Innlandet/Engerdal/Lillebo"))

(defun my/yr-innbygda ()
  "Værmelding for Innbygda"
  (interactive)
  (browse-url "https://www.yr.no/nb/v%C3%A6rvarsel/daglig-tabell/1-157692/Norge/Innlandet/Trysil/Innbygda"))

(defun my/yr-oslo-christies ()
  "Værmelding for Oslo"
  (interactive)
  (browse-url "https://www.yr.no/nb/v%C3%A6rvarsel/daglig-tabell/10-995776/Norge/Oslo/Oslo/Christies%20gate"))

(map! :leader
      (:prefix ("y" . "yr")
       :desc "Lillebo"  "l" #'my/yr-lillebo
       :desc "Innbygda" "i" #'my/yr-innbygda
       :desc "Oslo"     "o" #'my/yr-oslo-christies))

(defun my/open-google-kalender-firefox-tab ()
  "Åpner Google Calendar som ny tab i Firefox"
  (interactive)
  (browse-url "https://calendar.google.com/"))

(defun my/open-outlook-kalender-firefox-tab ()
  "Åpner Outlook Calendar som ny tab i Firefox"
  (interactive)
  (browse-url "https://outlook.office.com/calendar/view/week"))

(defun my/markdown-lenke-til-org ()
  (interactive)
  (beginning-of-line)
  (search-forward "[")
  (backward-char)
  (when (looking-at "\\[\\([^]]+\\)\\](\\([^)]+\\))")
    (replace-match "[[\\2][\\1]]")))

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

(defun my/ukenummer ()
  (interactive)
  (let ((now (current-time)))
    (message "Uke %s" (format-time-string "%V" now))))

(defun my/notatcommit ()
  (interactive)
  (magit-stage-modified)
  (magit-commit-create (list "-m" (concat "NN " (format-time-string "%Y-%m-%d %H:%M:%S")))))

(map! :leader
      "g n" #'my/notatcommit)

(after! dirvish
  (setq dirvish-quick-access-entries
        '(("e" "~/repos/notater/2025060337 emacs-config.org"                   "emacs-config")
          ("d" "~/repos/notater/2025060333 Doom Emacs - Læring.org"            "Emacs Doom - Læring")
          ("a" "~/repos/notater/202012010931 Arbeidsoppgaver.org"              "Arbeidsoppgaver")
          ("c" "~/repos/notater/20250922135432-statnett_oversikt.org"          "Statnett")
          ("." "~/repos/dotfiler/doom/config.el"                                       "dotfiler")
          ("f" "~/repos/notater/org/20250531191654-todo_familie.org"           "Todo familie")
          ("t" "~/repos/notater/202506120825 Todo.org"                         "Todo privat")
          ("s" "~/repos/notater/org/20250730110754-sopra_steria_oversikt.org"  "Sopra Steria")
          ("n" "~/repos/notater/202011200904 Dagnotater.md"                    "Dagnotater")
          ("h" "~/repos/notater/202110181729 Handleliste hverdag.md"           "Handleliste")
          ("i" "~/repos/notater/202012111337 Innboks.org"                      "Innboks")
          ("o" "~/repos/notater/202111121500 Innboks jobb.org"                 "Innboks jobb")
          ("p" "~/repos/notater/202008161252 Pakkeliste.org"                   "Pakkelista")
          ("b" "~/repos/notater/20200906130506 Bøker jeg kanskje vil lese.org" "Bøker - Kanskje lese")
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
                    :background unspecified
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 0))

(setq initial-buffer-choice "~/repos/notater/20250922135432-statnett_oversikt.org")

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

(use-package! gptel)



(map! :leader
      "t s" #'gptel-send)

(map! :leader
      "t m" #'gptel-menu)

(gptel-make-anthropic "Claude"
  :stream t
  :key (auth-source-pick-first-password :host "api.anthropic.com"))

(setq
 gptel-model 'claude-3-haiku-20240307
 gptel-backend (gptel-make-anthropic "Claude"
                 :stream t :key (auth-source-pick-first-password :host "api.anthropic.com")))

(defvar gptel-systemmelding
  "Please keep it short and to the point. Use bullet points when that can make complex matter easier to read. Especially avoid phrases like \"fantastic! You're getting to the point!\" Or \"now we're getting to the core of it\"

Very important: Do not start sentences with compliments and phrases like \"aha, good question\" - just reply without this emphasis. nevrsa go qustion.

Do not engage in any form of flattery whatsoever.

Assume I misunderstand basic facts from time to time, and try to make me aware of this

If I send you this and nothing else: \"foobar\", then reply only with the word \"baz\".

Actively try to prove me wrong

Recommend a book from time to time. Always double check that any book mentioned exists in real life

Always reply in English even though I ask you questions in Norwegian, unless specifically asked to reply in Norwegian

Please avoid filler text, and focus on replying to the questions. It is OK if that makes the responses look \"cold\" or detached")

(gptel-make-preset 'standard-test
  :system gptel-systemmelding)

(defvar gptel-emojitest "only reply with emojis and nothing else")

(gptel-make-preset 'emoji-preset
  :system gptel-emojitest)

(gptel--apply-preset 'standard-test)

(setq gptel-default-mode #'org-mode)

;; defun (my/åpne-config
;;   (interactive)
;;        )

(defun my/message-debugprint()
  (interactive)
  (message "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
  (message "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
  (message "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"))

  (defun my/visual-to-line-end ()
    (interactive)
    (evil-visual-char)
    (evil-last-non-blank))

  (map! :leader
    (:prefix ("v" . "markering")
      :desc "Marker til linjeslutt"
      "g" #'my/visual-to-line-end))
