;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;; (setq debug-on-error t)

;; Adjust garbage collection thresholds during startup, and thereafter

(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(update-load-path)

(setq custom-file (locate-user-emacs-file "custom.el"))

(require 'init-basic)
(require 'init-elpa)
(require 'init-package)
(require 'init-scratch)
(require 'init-xref)
(require 'init-exec-path)
(require 'init-editing-utils)
(require 'init-windows)
(require 'init-recentf)
(require 'init-minibuffer)
(require 'init-ibuffer)
(require 'init-tools)
(require 'init-org)
(require 'init-git)
(require 'init-projectile)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-flycheck)
(require 'init-ctags)
(require 'init-lsp)
(require 'init-javascript)
(require 'init-yaml)
(require 'init-beancount)
(require 'init-rss)
(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
