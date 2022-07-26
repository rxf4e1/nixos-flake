;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Rafael M M"
      user-mail-address "rxf4el@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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
;; (setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
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

;;; [Modus-Themes];;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! modus-themes
  :config
  (modus-themes-load-themes)
  (setq doom-theme 'modus-vivendi)
  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

;;; [Denote] ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! denote
  :config
  (setq denote-directory (expand-file-name "~/Library/Zettel")
        denote-known-keywords '("emacs" "biology" "politics" "economics")
        denote-file-type nil
        denote-prompts '(title keywords))
  (add-hook! find-file-hook #'denote-link-buttonize-buffer)
  (add-hook! dired-mode-hook #'denote-dired-mode))

(map! :leader
      :desc "Denote"              :n "d n" #'denote
      :desc "Denote Type"         :n "d N" #'denote-type
      :desc "Denote Date"         :n "d d" #'denote-date
      :desc "Denote Subdirectory" :n "d s" #'denote-subdirectory
      :desc "Denote Link"         :n "d i" #'denote-link
      :desc "Denote Add Link"     :n "d I" #'denote-link-add-links
      :desc "Denote Find File"    :n "d l" #'denote-link-find-file
      :desc "Denote Backlinks"    :n "d b" #'denote-link-backlinks
      :desc "Denote Rename"       :n "d r" #'denote-link-dired-rename-file)

;;; [Keycast] ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(with-eval-after-load 'keycast
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update))
    (dolist (input '(self-insert-command
                   org-self-insert-command))
    (add-to-list 'keycast-substitute-alist `(,input "." "Typing…"))))
  (setq keycast-mode-line-remove-tail-elements nil)
  (add-to-list 'global-mode-string '("" keycast-mode-line " ")))
(keycast-mode)

;;; [Mode-Line] ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq column-number-mode t
      mode-line-percent-position '(-3 "%p")
      mode-line-position-column-line-format '(" %l,%c")
      mode-line-compact nil)
(setq-default mode-line-format
              '("%e"
                mode-line-front-space
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-frame-identification
                mode-line-buffer-identification
                "  "
                mode-line-position
                ;; mode-line-modes
                "  "
                (vc-mode vc-mode)
                "  "
                mode-line-misc-info
                mode-line-end-spaces))
