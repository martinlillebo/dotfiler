;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hei, ikke endre denne filen direkte - den veves ut fra literalfilen ~emacs-config.org~ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq confirm-kill-emacs nil)

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

(setq display-line-numbers-type 'relative)

(setq bookmark-save-flag 1)

(setq org-log-done 'time)  ; adds CLOSED timestamp when marking DONE 🕒

(setq org-capture-templates
     '(("m" "Innboks jobb" item (file+headline "~/repos/notater/202111121500 Innboks jobb.org" "Tasks")
        "%?")
;     ("o" "Innbokos jobb TODO" entry (file "~/repos/notater/capture-test.org")
;        "* TODO %?")
     ("i" "Innboks jobb TODO" entry (file "~/repos/notater/capture-test.org")
        "* TODO %?")))

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

(setq org-directory (expand-file-name "~/repos/notater/org/"))

(setq org-roam-directory org-directory)
(after! org-roam
  (org-roam-db-autosync-mode))

;; toc-org config
(setq org-export-with-todo-keywords t)

;; Mal for å sette opp nye notater
(defun my/datert-orgfil (title)
  "Create a new Org file with format YYYYMMDDMM Title.org in ~/repos/notater/."
  (interactive "sTitle: ")
  (let* ((timestamp (format-time-string "%Y%m%d%M"))
         (filename (format "~/repos/notater/%s %s.org" timestamp title)))
    (find-file filename)))

(setq auto-save-visited-interval 15)
(auto-save-visited-mode +1)



;; hotkey til funksjonen over
(map! :leader
      :desc "New dated org file"
      "- RET" #'my/datert-orgfil)


(setq initial-buffer-choice "~/repos/notater/2025060408 doom-startside.org")

(nyan-mode 1)
