;; init-ctags.el --- Initialize TAGS configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; TAGS configurations.
;;

;;; Code:

;; Ctags IDE on the True Editor
;; @see https://github.com/universal-ctags/citre#quick-start
(use-package citre
  :diminish
  :bind (("C-x c j" . citre-jump)
         ("C-x c J" . citre-jump-back)
         ("C-x c p" . citre-peek)
         ("C-x c a" . citre-ace-peek)
         ("C-x c u" . citre-update-this-tags-file))
  :init
  (require 'citre-config)
  :config
  (with-no-warnings
    (with-eval-after-load 'projectile
      (setq citre-project-root-function #'projectile-project-root)))
  :hook (js-mode . (lambda ()
                     (setq-local citre-enable-xref-integration t
                                 citre-enable-capf-integration t)))
  :custom
  ;; Set this if you want to always use one location to create a tags file.
  (citre-default-create-tags-file-location 'global-cache)
  ;; See the "Create tags file" section above to know these options
  ( citre-use-project-root-when-creating-tags t)
  (citre-prompt-language-for-ctags-command nil)
  ;; By default, when you open any file, and a tags file can be found for it,
  ;; `citre-mode' is automatically enabled.  If you only want this to work for
  ;; certain modes (like `prog-mode'), set it like this.
  (citre-auto-enable-citre-mode-modes '(prog-mode))
  )

(provide 'init-ctags)
;;; init-ctags.el ends here

