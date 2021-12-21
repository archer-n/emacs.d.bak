;;; init-java.el --- Support for working with Java -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package lsp-java
  :after lsp-mode
  :init
  (use-package dap-java :ensure nil)
  :hook ((java-mode . lsp-deferred))
  :config
  ;; lombok
  (let ((lombok-jar-path (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar")))
    (setq lsp-java-vmargs (list (concat "-javaagent:" lombok-jar-path))))
  ;; https://github.com/dgileadi/vscode-java-decompiler
  (setq lsp-java-content-provider-preferred "fernflower")
  (setq lsp-java-inhibit-message t))

(provide 'init-java)
;;; init-java.el ends here
