;;; init-xref.el --- xref  -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(require 'xref)
(setq xref-show-xrefs-function #'xref-show-definitions-completing-read)
(setq xref-show-definitions-function #'xref-show-definitions-completing-read)
(global-set-key (kbd "C-,") 'xref-find-references)

(provide 'init-xref)
;;; init-xref.el ends here


