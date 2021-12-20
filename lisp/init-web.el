;;; init-web.el --- Support for Web development -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package  web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.wxml$" . web-mode)))

(add-to-list 'auto-mode-alist '("\\.wxss$" . css-mode))

(provide 'init-web)
;;; init-web.el ends here
