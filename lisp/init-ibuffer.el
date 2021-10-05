;; init-buffer.el --- Initialize ibuffer configurations.	-*- lexical-binding: t -*-
;; Commentary:
;;
;; IBuffer configurations.
;;

;;; Code:


(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :init (setq ibuffer-filter-group-name-face '(:inherit (font-lock-string-face bold))))

;; Group ibuffer's list by project root
(use-package ibuffer-projectile
  :functions ibuffer-do-sort-by-alphabetic
  :hook ((ibuffer . (lambda ()
                      (ibuffer-projectile-set-filter-groups)
                      (unless (eq ibuffer-sorting-mode 'alphabetic)
                        (ibuffer-do-sort-by-alphabetic)))))
  :config
  (setq ibuffer-projectile-prefix "Project: "))

(provide 'init-ibuffer)
;;; init-ibuffer.el ends here
