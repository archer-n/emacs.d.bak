;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;; (setq debug-on-error t)


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq custom-file (locate-user-emacs-file "custom.el"))

(require 'init-basic)
(require 'init-elpa)
(require 'init-package)
(require 'init-xref)
(require 'init-exec-path)
(require 'init-editing-utils)
(require 'init-windows)
(require 'init-minibuffer)
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

(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
