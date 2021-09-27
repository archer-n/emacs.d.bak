;;; init-yaml.el --- Support for yaml -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
  :hook (yaml-mode . lsp))

(provide 'init-yaml)
;;; init-yaml.el ends here
