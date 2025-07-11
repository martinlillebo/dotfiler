

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hei, ikke endre denne filen direkte - den veves ut fra literalfilen ~emacs-config.org~ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq confirm-kill-emacs nil)

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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha

(add-hook 'server-after-make-frame-hook
          (lambda () (when (fboundp 'catppuccin-reload)
                       (catppuccin-reload))))

(when (fboundp 'catppuccin-reload)
  (catppuccin-reload))

(custom-set-faces!
  ;;'(line-number-current-line :weight bold :foreground "#cdd6f4")  ;; Current line number
  '(line-number              :foreground "#b8c2dc"))               ;; Other line numbers

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
               "~/repos/ansible-desktop"
               "~/repos/EcoPlatform"))
    (projectile-add-known-project p)))

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

(setq org-directory (expand-file-name "~/repos/notater/org/"))

(setq org-roam-directory org-directory)
(after! org-roam
  (org-roam-db-autosync-mode))

(setq org-capture-templates
     '(("m" "Innboks jobb" item (file+headline "~/repos/notater/202111121500 Innboks jobb.org" "Tasks")
        "%?")
;     ("o" "Innbokos jobb TODO" entry (file "~/repos/notater/capture-test.org")
;        "* TODO %?")
     ("i" "Innboks jobb TODO" entry (file "~/repos/notater/capture-test.org")
        "* TODO %?")))

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
t   (org-export-to-file 'html outfile nil nil nil nil nil)))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode))

(after! dirvish
  (setq dirvish-quick-access-entries
        '(("e" "~/repos/notater/2025060337 emacs-config.org"                   "emacs-config")
          ("d" "~/repos/notater/2025060333 Doom Emacs - Læring.org"            "Emacs Doom - Læring")
          ("a" "~/repos/notater/202012010931 Arbeidsoppgaver.org"              "Arbeidsoppgaver")
          ("f" "~/repos/notater/org/20250531191654-todo_familie.org"           "Todo familie")
          ("t" "~/repos/notater/202506120825 Todo.org"                         "Todo privat")
          ("s" "~/repos/notater/202507040828 2025-07 jobb.org"                 "2025-07 jobb")
          ("n" "~/repos/notater/202507040829 2025-07.org"                      "2025-07")
          ("i" "~/repos/notater/202012111337 Innboks.org"                      "Innboks")
          ("o" "~/repos/notater/202111121500 Innboks jobb.org"                 "Innboks jobb")
          ("b" "~/repos/notater/20200906130506 Bøker jeg kanskje vil lese.org" "Bøker - Kanskje lese")
          ;; Add more entries as desired
          )))

(setq initial-buffer-choice "~/repos/notater/2025060408 doom-startside.org")

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

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-jazz ()
    "Spiller av NRK Jazz"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/jazz_mp3_h")))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-klassisk ()
    "Spiller av NRK Klassisk"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/klassisk_mp3_h")))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p2 ()
    "Spiller av NRK P2"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p2_mp3_h")))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p3 ()
    "Spiller av NRK P3"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p3_mp3_h")))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-nrk-p13 ()
    "Spiller av NRK P13"
    (interactive)
    (emms-play-url "https://cdn0-47115-liveicecast0.dna.contentdelivery.net/p13_mp3_h")))

(use-package emms
  :config
  (emms-minimalistic)
  (setq emms-player-list '(emms-player-mpv)
        emms-player-mpv-command-name "mpv")

  (defun my/radio-freecodecamp ()
    "Spiller av freeCodeCamp sin nettradio"
    (interactive)
    (emms-play-url "https://coderadio-admin-v2.freecodecamp.org/listen/coderadio/radio.mp3")))

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
