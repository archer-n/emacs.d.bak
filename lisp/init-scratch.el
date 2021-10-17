;;; init-scratch.el --- scratch  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(setq-default initial-scratch-message
              (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))

(use-package immortal-scratch
  :init
  (add-hook 'after-init-hook 'immortal-scratch-mode))

(provide 'init-scratch)
;;; init-scratch.el ends here
