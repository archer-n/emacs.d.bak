;;; init-company.el --- Completion with company -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; The completion engine

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :bind (:map company-mode-map
              ("M-/" . company-complete)
              ([remap completion-at-point] . company-complete)
         :map company-active-map
         ("C-s"     . company-filter-candidates)
         ([tab]     . company-complete-common-or-cycle)
         ([backtab] . company-select-previous-or-abort)
         ("C-d" . company-show-company-show-doc-buffer))
  :config

  ;; Config for company mode.
  (setq-default company-dabbrev-other-buffers t
                company-dabbrev-minimum-length 1
                company-dabbrev-code-everywhere t
                company-tooltip-align-annotations t
                company-dabbrev-downcase nil
                company-dabbrev-ignore-case t)

  ;; Customize company backends.
  (setq-default company-backends '((:separate company-files company-capf company-dabbrev-code company-dabbrev )))

  ;; Remove duplicate candidate.
  (add-to-list 'company-transformers #'delete-dups)

  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.2)
  ;; Easy navigation to candidates with M-<n>
  (company-show-quick-access t)
  (company-require-match nil)
  (company-tooltip-width-grow-only t)
  (company-tooltip-align-annotations t)
  ;; No icons
  (company-format-margin-function #'company-text-icons-margin))


(provide 'init-company)
;;; init-company.el ends here
