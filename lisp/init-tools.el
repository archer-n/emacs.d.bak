;;; init-tools.el --- We all like productive tools -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

;; Tips for next keystroke
(use-package which-key
  :ensure t
  :diminish
  :hook (after-init . which-key-mode)
  :config
  (which-key-add-key-based-replacements
    "C-c !" "flycheck")
  :custom
  (which-key-idle-delay 0.5)
  (which-key-add-column-padding 1))

;; The blazing grep tool
;;
;; Press C-c s to search
(use-package rg
  :ensure t
  :hook (after-init . rg-enable-default-bindings))

(provide 'init-tools)
;;; init-tools.el ends here
