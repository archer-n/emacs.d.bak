;;; init-yaml.el --- Support for xml -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (require 'nxml-mode nil t)
  (add-hook 'nxml-mode-hook #'lsp))

(provide 'init-xml)
;;; init-xml.el ends here
