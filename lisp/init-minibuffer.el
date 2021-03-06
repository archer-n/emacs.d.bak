;;; init-minibuffer.el --- Config for minibuffer completion -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package orderless
  :ensure t
  :custom (completion-styles '(basic partial-completion orderless)))

(use-package consult
  :after vertico
  :ensure t
  :init
  :bind (([remap switch-to-buffer] . consult-buffer)
         ([remap switch-to-buffer-other-window] . consult-buffer-other-window)
         ([remap goto-line] . consult-goto-line)
         ("M-s i"              . consult-imenu)
         ([remap bookmark-jump]      . consult-bookmark)
         ("M-s r" . consult-recent-file)
         ("M-s /" . consult-line)
         ("M-?" . consult-ripgrep))
  :custom
  (consult-preview-key (kbd "M-."))
  (consult-project-root-function #'projectile-project-root))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package embark
  :ensure t
  :bind (:map minibuffer-local-map
         ("M-o"     . embark-act)
         ("C-c C-o" . embark-export)
         ("C-c C-c" . embark-collect-snapshot))
  :custom
  (embark-collect-initial-view-alist '((t . list)))
  (embark-collect-live-initial-delay 0.15)
  (embark-collect-live-update-delay 0.15))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :after embark consult)

(provide 'init-minibuffer)
;;; init-minibuffer.el ends here
