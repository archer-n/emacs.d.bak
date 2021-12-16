;;; init-translate.el --- Translation commands -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'popweb-dict-youdao)
(global-set-key (kbd "M-s l") 'popweb-dict-youdao-pointer)


;; Automatic translation plug-in
(require 'insert-translated-name)
(setq insert-translated-name-translate-engine 'youdao)
(global-set-key (kbd "M-s n") 'insert-translated-name-insert)

(provide 'init-translate)
;;; init-translate.el ends here
