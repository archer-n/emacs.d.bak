;;; init-java.el --- Support for working with Java -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;;; eglot

;;; NOTE: 目前只能跳转项目内的代码
(use-package eglot :ensure t)
(require 'eglot)

(defconst my-eglot-eclipse-jdt-home (expand-file-name  "jdt-language-server-1.8.0-202201261434/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar" user-emacs-directory))

(defun my-eglot-eclipse-jdt-contact (interactive)
  "Contact with the jdt server input INTERACTIVE."
  ;; java.contentProvider.preferred
  ;; (setq eglot-workspace-configuration '((:java . (:contentProvider (:preferred "fernflower")
  ;;                                                 :autobuild (:enable t)
  ;;                                                 :dependency (:packagePresentation "flat")
  ;;                                                 :project (:referencedLibraries ["lib/**/*.jar"])
  ;;                                                 :maven (:downloadSources t)
  ;;                                                 ))))
  (let ((cp (getenv "CLASSPATH")))
    (setenv "CLASSPATH" (concat cp ":" my-eglot-eclipse-jdt-home))
    (unwind-protect (let ((command (eglot--eclipse-jdt-contact nil))
                          (lombok-jar-path (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar")))
                      (cons (car command)
                            (flatten-list (list
                                           (cadr command)
                                           (concat "-javaagent:" lombok-jar-path)
                                           (cddr command)
                                           "--add-modules=ALL-SYSTEM"
                                           "--add-opens java.base/java.util=ALL-UNNAMED"
                                           "--add-opens java.base/java.lang=ALL-UNNAMED"))))
      (setenv "CLASSPATH" cp))))

(setcdr   (assq 'java-mode eglot-server-programs) #'my-eglot-eclipse-jdt-contact)

(add-hook 'java-mode-hook 'eglot-ensure)

(add-hook 'java-mode-hook (lambda ()
                            (setq-local c-basic-offset 2) ;; The indentation configuration
                            (setq-local tab-width 2) ;; The indentation configuration
                            (setq-local company-backends '(company-capf))))

;; ----------------------------------------------------------------------------------------------------

;; lsp-mode
;; (use-package lsp-java
;;   :after lsp-mode
;;   :init
;;   (use-package dap-java :ensure nil)
;;   :hook ((java-mode . (lambda ()
;;                         (setq-local company-backends '(company-capf))
;;                         (setq-local c-basic-offset 2) ;; The indentation configuration
;;                         ))
;;          (java-mode . lsp-deferred))
;;   :config
;;   (setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.8.0/jdt-language-server-1.8.0-202201261434.tar.gz")
;;   (setq lsp-java-format-settings-url (expand-file-name "eclipse-java-google-style.xml" user-emacs-directory))
;;   (setq lsp-java-format-settings-profile "GoogleStyle")
;;   (let ((lombok-jar-path (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar")))
;;     (setq lsp-java-vmargs (list
;;                            (concat "-javaagent:" lombok-jar-path))))

;;   (setq lsp-java-trace-server "messages"
;;         lsp-java-maven-download-sources t
;;         lsp-java-inhibit-message t
;;         ;; https://github.com/dgileadi/vscode-java-decompiler
;;         lsp-java-content-provider-preferred "fernflower"))

(use-package mvn)

(provide 'init-java)
;;; init-java.el ends here
