;;; init-java.el --- Support for working with Java -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(use-package lsp-java
  :after lsp-mode
  :init
  (use-package dap-java :ensure nil)
  :hook ((java-mode . lsp-deferred))
  ;; :custom
  ;; (c-basic-offset 2) ;; The indentation configuration
  :config
  (setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.6.0/jdt-language-server-1.6.0-202111261512.tar.gz")
  ;; (setq lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml")
  (setq lsp-java-format-settings-url (expand-file-name "eclipse-java-google-style.xml" user-emacs-directory))
  (setq lsp-java-format-settings-profile "GoogleStyle")
  ;; current VSCode defaults
  (setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx4G" "-Xms512m"))
  ;; lombok
  (let ((lombok-jar-path (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar")))
    (setq lsp-java-vmargs (list (concat "-javaagent:" lombok-jar-path))))
  ;; https://github.com/dgileadi/vscode-java-decompiler
  (setq lsp-java-content-provider-preferred "fernflower")
  (setq lsp-java-inhibit-message t))

(provide 'init-java)
;;; init-java.el ends here
