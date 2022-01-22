;;; init-yaml.el --- Support for xml -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (require 'nxml-mode nil t)
  (add-hook 'nxml-mode-hook
            (lambda ()
              (setq-local company-dabbrev-char-regexp "[\\.0-9a-z-_'/]") ;adjust regexp make `company-dabbrev' search words like `dabbrev-expand'
              (lsp-deferred))))

(provide 'init-xml)
;;; init-xml.el ends here
