

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
(setq catppuccin-flavor 'macchiato) ;; or 'latte, 'macchiato, or 'mocha

(add-hook 'server-after-make-frame-hook
          (lambda () (when (fboundp 'catppuccin-reload)
                       (catppuccin-reload))))

(when (fboundp 'catppuccin-reload)
  (catppuccin-reload))

(setq projectile-project-search-path '("~/repos/notater/"))

(after! projectile
  (setq projectile-require-project-root nil)  ; allow fallback roots
  (add-to-list 'projectile-project-root-functions
               (lambda (_) (expand-file-name "~/repos/notater/")))
;; Legger til vibe-config for å fjerne feilmelding
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up)))

(after! org
  (setq org-todo-keyword-faces
        '(;;("TODO" . (:foreground "#ffff00" :weight bold))
          ("STRT" . (:foreground "#ffff00" :weight bold))
          ("KILL" . (:foreground "#595e60" :weight bold))
          ("WAIT" . (:foreground "#B4F8C8" :weight bold))
          ("PROJ" . (:foreground "#B4F8C8" :weight bold))
          ;;("DONE" . (:foreground "forest green" :weight bold))
          )))

(setq org-log-done 'time)  ; adds CLOSED timestamp when marking DONE 🕒

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
    (org-export-to-file 'html outfile nil nil nil nil nil)))

(after! dirvish
  (setq dirvish-quick-access-entries
        '(("e" "~/repos/notater/2025060337 emacs-config.org"                   "emacs-config")
          ("d" "~/repos/notater/2025060333 Doom Emacs - Læring.org"            "Emacs Doom - Læring")
          ("a" "~/repos/notater/202012010931 Arbeidsoppgaver.org"              "Arbeidsoppgaver")
          ("j" "~/repos/notater/202505280758 2025-06 jobb.org"                 "2025-06 jobb")
          ("i" "~/repos/notater/202012111337 Innboks.org"                      "Innboks")
          ("n" "~/repos/notater/202505280757 2025-06.org"                      "2025-06")
          ("b" "~/repos/notater/20200906130506 Bøker jeg kanskje vil lese.org" "Bøker - Kanskje lese")
          ;; Add more entries as desired
          )))

(setq initial-buffer-choice "~/repos/notater/2025060408 doom-startside.org")

(nyan-mode 1)


(after! org
  (add-hook 'org-mode-hook #'rainbow-mode))

(after! vimgolf
  (map! :leader
        ;; call vimgolf prompt
        "g v" #'vimgolf
        ;; default bindings as listed in README
        "g V" #'vimgolf-submit))
