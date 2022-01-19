;;; init-auto-save.el --- Init for auto-save.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)
(setq auto-save-delete-trailing-whitespace t)

(provide 'init-auto-save)
;;; init-auto-save.el ends here.
