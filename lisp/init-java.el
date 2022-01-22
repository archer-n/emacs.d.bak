;;; init-java.el --- Support for working with Java -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(use-package lsp-java
  :after lsp-mode
  :init
  (use-package dap-java :ensure nil)
  :hook ((java-mode . (lambda ()
                        (setq-local company-backends '(company-capf))
                        (setq-local c-basic-offset 2) ;; The indentation configuration
                        (setq-local company-idle-delay 0.2)
                        (setq-local company-minimum-prefix-length 3)))
         (java-mode . lsp-deferred))
  :config
  (setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.7.0/jdt-language-server-1.7.0-202112161541.tar.gz")
  (setq lsp-java-format-settings-url (expand-file-name "eclipse-java-google-style.xml" user-emacs-directory))
  (setq lsp-java-format-settings-profile "GoogleStyle")
  (let ((lombok-jar-path (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar")))
    (setq lsp-java-vmargs (list
                           "-XX:+UseParallelGC"
                           "-XX:GCTimeRatio=4"
                           "-XX:AdaptiveSizePolicyWeight=90"
                           "-Dsun.zip.disableMemoryMapping=true"
                           "-Xmx8G"
                           "-Xms100m"
                           (concat "-javaagent:" lombok-jar-path))))

  (setq lsp-java-trace-server "messages"
        lsp-java-maven-download-sources t
        lsp-java-inhibit-message t
        ;; https://github.com/dgileadi/vscode-java-decompiler
        lsp-java-content-provider-preferred "fernflower"))


(use-package mvn)

(provide 'init-java)
;;; init-java.el ends here
