;;; init-git.el --- Git is awesome -*- lexical-binding: t -*-

;;; Commentary:
;;
;; git-messenger has been superseded by {C-x v h} (`vc-region-history')

;;; Code:

;; The awesome git client
;;
;; Explicit binding makes it load lazily although it's the default.
;; See `magit-define-global-key-bindings' for more information.
(use-package magit
  :ensure t
  :hook (git-commit-setup . git-commit-turn-on-flyspell)
  :bind (("C-x g"   . magit-status)
         ("C-x M-g" . magit-dispatch)
         ("C-c M-g" . magit-file-dispatch))
  :custom
  (magit-diff-refine-hunk t)
  (magit-diff-paint-whitespace nil)
  (magit-ediff-dwim-show-on-hunks t))

;; NOTE: `diff-hl' depends on `vc'
(use-package vc
  :ensure nil
  :custom
  (vc-follow-symlinks t)
  (vc-allow-async-revert t)
  (vc-handled-backends '(Git)))

;; Highlight uncommitted changes using VC
(use-package diff-hl
  :ensure t
  :hook ((after-init         . global-diff-hl-mode)
         (magit-pre-refresh  . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh)
         (dired-mode         . diff-hl-dired-mode-unless-remote)))

;; Visual diff interface
(use-package ediff
  :ensure nil
  ;; Restore window config after quitting ediff
  :hook ((ediff-before-setup . ediff-save-window-conf)
         (ediff-quit         . ediff-restore-window-conf))
  :config
  (defvar local-ediff-saved-window-conf nil)

  (defun ediff-save-window-conf ()
    (setq local-ediff-saved-window-conf (current-window-configuration)))

  (defun ediff-restore-window-conf ()
    (when (window-configuration-p local-ediff-saved-window-conf)
      (set-window-configuration local-ediff-saved-window-conf)))
  :custom
  (ediff-highlight-all-diffs t)
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-merge-split-window-function 'split-window-horizontally))

;; Open current file in browser
(use-package browse-at-remote
  :ensure t
  :bind (:map vc-prefix-map
         ("b" . bar-browse)         ;; was `vc-switch-backend'
         ("c" . bar-to-clipboard))
  :custom
  (browse-at-remote-add-line-number-if-no-region-selected nil))

(use-package git-modes)

(use-package git-timemachine
  :bind (( "C-x v t" . git-timemachine-toggle)))

(provide 'init-git)

;;; init-git.el ends here
