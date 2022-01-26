;;; init-web.el --- Support for Web development -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.wxss$" . css-mode))

(use-package emmet-mode
  :hook ((wxml-mode . emmet-mode))
)

(provide 'init-web)
;;; init-web.el ends here
