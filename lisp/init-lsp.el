;;; init-lsp.el --- The completion engine and lsp client -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(defun dotfiles--lsp-deferred-if-supported ()
  "Run `lsp-deferred' if it's a supported mode."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp-deferred)))

(use-package lsp-mode
  :ensure t
  :hook (prog-mode . dotfiles--lsp-deferred-if-supported)
  :bind (:map lsp-mode-map
         ("C-c d" . lsp-describe-thing-at-point)
         ([remap xref-find-references] . lsp-find-references))
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
  (lsp-log-io nil)                       ;; debug only
  (lsp-auto-guess-root t)                ;; auto guess root
  (lsp-keep-workspace-alive nil)         ;; auto kill lsp server
  (lsp-eldoc-enable-hover nil))          ;; disable eldoc hover

(provide 'init-lsp)
;;; init-lsp.el ends here
