;;; init-web.el --- Support for Web development -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.vue$" . web-mode)))

(add-to-list 'auto-mode-alist '("\\.wxss$" . css-mode))

(use-package emmet-mode
  :hook ((wxml-mode . emmet-mode)
         (mhtml-mode . emmet-mode)))

(provide 'init-web)
;;; init-web.el ends here
