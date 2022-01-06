;;; init-lsp.el --- The completion engine and lsp client -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(defun dotfiles--lsp-deferred-if-supported ()
  "Run `lsp-deferred' if it's a supported mode."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp-deferred)))

;; Use plists for deserialization.
(setenv "LSP_USE_PLISTS" "t")

(use-package lsp-mode
  :ensure t
  :init
  (advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))
  :hook ((prog-mode . dotfiles--lsp-deferred-if-supported)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map lsp-mode-map
         ("C-c d" . lsp-describe-thing-at-point)
         ([remap xref-find-references] . lsp-find-references)
         ("C-." . lsp-find-implementation))
  :config
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-diagnostics-disabled-modes '(js-mode))
  (lsp-enable-imenu nil)                 ;; disable imenu
  (lsp-enable-links nil)                 ;; no clickable links
  (lsp-enable-folding nil)               ;; use `hideshow' instead
  (lsp-enable-snippet t)                 ;; no snippets, it requires `yasnippet'
  (lsp-enable-file-watchers nil)         ;; performance matters
  (lsp-enable-text-document-color nil)   ;; as above
  (lsp-enable-symbol-highlighting nil)   ;; as above
  (lsp-enable-on-type-formatting nil)    ;; as above
  (lsp-enable-indentation nil)           ;; don't change my code without my permission
  (lsp-headerline-breadcrumb-enable nil) ;; keep headline clean
  (lsp-modeline-code-actions-enable nil) ;; keep modeline clean
  (lsp-modeline-diagnostics-enable nil)  ;; as above
  (lsp-log-max nil)                      ;; disable message logging
  (lsp-log-io nil)                       ;; debug only
  (lsp-auto-guess-root t)                ;; auto guess root
  (lsp-keep-workspace-alive nil)         ;; auto kill lsp server
  (lsp-eldoc-enable-hover nil)           ;; disable eldoc hover
  :init
   ;; Enable LSP in org babel
    ;; https://github.com/emacs-lsp/lsp-mode/issues/377
    (cl-defmacro lsp-org-babel-enable (lang)
      "Support LANG in org source code block."
      (cl-check-type lang stringp)
      (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
             (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
        `(progn
           (defun ,intern-pre (info)
             (setq buffer-file-name (or (->> info caddr (alist-get :file))
                                        "org-src-babel.tmp"))
             (when (fboundp 'lsp-deferred)
                  ;; Avoid headerline conflicts
                  (setq-local lsp-headerline-breadcrumb-enable nil)
                  (lsp-deferred)))
           (put ',intern-pre 'function-documentation
                (format "Enable lsp in the buffer of org source block (%s)."
                        (upcase ,lang)))

           (if (fboundp ',edit-pre)
               (advice-add ',edit-pre :after ',intern-pre)
             (progn
               (defun ,edit-pre (info)
                 (,intern-pre info))
               (put ',edit-pre 'function-documentation
                    (format "Prepare local buffer environment for org source block (%s)."
                            (upcase ,lang))))))))

    (defvar org-babel-lang-list
      '("go" "python" "ipython" "ruby" "js" "css" "sass" "C" "rust" "java" "cpp" "c++" "shell"))
    
    (dolist (lang org-babel-lang-list)
      (eval `(lsp-org-babel-enable ,lang))))


(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))

(provide 'init-lsp)
;;; init-lsp.el ends here
