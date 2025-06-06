;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'macchiato) ;; or 'latte, 'macchiato, or 'mocha


;; (add-hook 'server-after-make-frame-hook #'catppuccin-reload) ;; for å unngå dette problemet: https://github.com/catppuccin/emacs/issues/121
;; nedenfor: chatgpt-magi fordi original fix ikke virka
(add-hook 'server-after-make-frame-hook
          (lambda () (when (fboundp 'catppuccin-reload)
                       (catppuccin-reload))))

(when (fboundp 'catppuccin-reload)
  (catppuccin-reload))


;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; Th
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Aktiverer Vim-esque relative linjenumre
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
               (lambda (_)
                 (expand-file-name "~/repos/notater/"))))


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


;; Forsøker å få Ansible til å kjøre i en literal org-fil:
;; 2025-06-01: Dette gir riktig syntax highlighting, men får den fortsatt ikke til å kjøre


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

;; \n Skrevet fra: %a \n"

;;(setq org-capture-templates
;;      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
;;         "* TODO %?\n  %i\n  %a")
;;        ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;         "* %?\nEntered on %U\n  %i\n  %a")))
;;;;
;;
;;        ("j" "Journal" entry (file+datetree "~/repos/notater/capture-test.org")
  ;;       "* %?\nEntered on %U\n  %i\n  %a")))

;; Fjerner vindu-baren på topp, og "minimize"/"maximize"-knappene og alt på den linja
;;  (add-to-list 'default-frame-alist '(undecorated . t))

(setq initial-buffer-choice "~/repos/notater/2025060408 doom-startside.org")


