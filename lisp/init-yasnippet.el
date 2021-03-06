;; init-yasnippet.el --- Initialize yasnippet configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Yasnippet configurations.
;;

;;; Code:

(use-package yasnippet
  :hook (after-init . yas-global-mode))

(use-package yasnippet-snippets
  :after yasnippet)

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
