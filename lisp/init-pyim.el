;;; init-pyim.el --- Support for Peng You input method -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package pyim
  :init
  (setq default-input-method "pyim"))

(use-package pyim-basedict
  :after pyim
  :init
  (pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
  )

(provide 'init-pyim)
;;; init-pyim.el ends here
