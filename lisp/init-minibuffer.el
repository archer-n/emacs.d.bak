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
  (defun archer/consult-grep-at-point (&optional dir initial)
    (interactive (list prefix-arg (when-let ((s (symbol-at-point)))
                                    (symbol-name s))))
    (consult-ripgrep dir initial))
  :bind (("M-s i"              . consult-imenu)
         ([remap bookmark-jump]      . consult-bookmark)
         ([remap recentf-open-files] . consult-recent-file)
         ([remap evil-show-marks]    . consult-mark)
         ("M-s /" . consult-line)
         ("M-?" . archer/consult-grep-at-point))
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
