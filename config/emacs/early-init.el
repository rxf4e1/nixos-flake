;;; Package: --- early-init.el -*- lexical-binding: t -*-

;;; Commentary:
;; This file is loaded before package.el is initialized, and before
;; the first graphical frame is initialized, by Emacs 27 (but not by
;; any previous version of Emacs). Trivia: I was the person to
;; implement support for early-init.el, after a protracted argument
;; between me and most of the rest of the Emacs mailing list.
;;
;; If the early init-file is available, we actually execute our entire
;; init process within it, by just loading the regular init-file.
;; (That file takes care of making sure it is only loaded once.)

;;; Code:

(setq load-prefer-newer t)

(require 'cl-lib)

(cl-letf* ((gc-cons-threshold most-positive-fixnum)
           (file-name-handler-alist nil)
           (load-source-file-function nil)
           (site-run-file nil)
           ;; Also override load to hide  superfluous loading messages
           (old-load (symbol-function 'load))
           ((symbol-function 'load)
            (lambda (file &optional noerror _nomessage &rest args)
              (apply old-load
                     file
                     noerror
                     (not (eq debug-on-error 'startup))
                     args)))))

;; Get rid of screen eaters
(unless (and  (display-graphic-p) (eq system-type 'gnu/linux))
  (push '(menu-bar-lines . 0) default-frame-alist))
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; add paths to the list
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Load the regular init file
(load
 (expand-file-name "init.el" user-emacs-directory) nil 'nomessage 'nosuffix)

(provide 'early-init)
;;; early-init.el ends here
