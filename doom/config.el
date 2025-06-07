;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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



(setq display-line-numbers-type 'relative)



;; Gjør at bokmerker holder seg lagra på tvers av reboots
(setq bookmark-save-flag 1)

;; prøver å autolagre buffere:
(setq auto-save-visited-interval 15)
(auto-save-visited-mode +1)

;; Projectile prosjekter
(setq projectile-project-search-path '("~/repos/notater/"))

;; PRøver å få projectile til å alltid søke i /notater om jeg ikke har spesifisert noe annet, for akkurat nå søker den alltid i /dotfiler, som ikke er nyttig
(after! projectile
  (setq projectile-require-project-root nil)  ; allow fallback roots
  (add-to-list 'projectile-project-root-functions
               (lambda (_) (expand-file-name "~/repos/notater/")))
;; Legger til vibe-config for å fjerne feilmelding
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up)))

;; 🐱
(nyan-mode 1)

;; fjerner "really quit Emacs?"-prompt ved exit
(setq confirm-kill-emacs nil)

(setq org-directory (expand-file-name "~/repos/notater/org/"))

(setq org-roam-directory org-directory)
(after! org-roam
  (org-roam-db-autosync-mode))

;; toc-org config
(setq org-export-with-todo-keywords t)


(add-load-path! "~/.config/doom/lokal")

(after! org
  (require 'ob-ansible)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ansible . t)  ; enables org-babel-execute:ansible 😊
     ;; …other languages you already have…
     )))


;; Mal for å sette opp nye notater
(defun my/datert-orgfil (title)
  "Create a new Org file with format YYYYMMDDMM Title.org in ~/repos/notater/."
  (interactive "sTitle: ")
  (let* ((timestamp (format-time-string "%Y%m%d%M"))
         (filename (format "~/repos/notater/%s %s.org" timestamp title)))
    (find-file filename)))

;; hotkey til funksjonen over
(map! :leader
      :desc "New dated org file"
      "- RET" #'my/datert-orgfil)


;; Forsøk på å sette en ny capture template
(setq org-capture-templates
     '(("m" "Innboks jobb" item (file+headline "~/repos/notater/202111121500 Innboks jobb.org" "Tasks")
        "%?")
;     ("o" "Innbokos jobb TODO" entry (file "~/repos/notater/capture-test.org")
;        "* TODO %?")
     ("i" "Innboks jobb TODO" entry (file "~/repos/notater/capture-test.org")
        "* TODO %?")))

(setq initial-buffer-choice "~/repos/notater/2025060408 doom-startside.org")
