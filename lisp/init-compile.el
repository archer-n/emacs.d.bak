;;; init-compile.el --- Helpers for M-x compile -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq-default compilation-scroll-output t)

(with-eval-after-load 'compile
  (require 'ansi-color)
  (defun archer/colourise-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
    (add-hook 'compilation-filter-hook 'archer/colourise-compilation-buffer))

(provide 'init-compile)
;;; init-compile.el ends here
