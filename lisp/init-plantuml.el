;;; init-plantuml.el ---  plantuml mode configurations -*- lexical-binding: t -*-

;;; Commentary:
;;
;;; Code:

;; company-plantuml
(require 'cl-lib)

(defun company-plantuml (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-plantuml))
    (prefix (let* ((symbol (company-grab-symbol))
                  (max-match-result (try-completion symbol plantuml-kwdList)))
              (if (length> max-match-result 0)
                  symbol)))
    (candidates (all-completions arg plantuml-kwdList))))

(use-package plantuml-mode
  :init
  (add-hook 'plantuml-mode-hook
            (lambda ()
              (setq-local company-backends '(company-plantuml
                                             (company-dabbrev-code company-keywords)
                                             company-dabbrev))))
  :custom
  (setq org-plantuml-jar-path
        (expand-file-name "~/workspace/tools/plantuml-1.2021.16.jar")))





(provide 'init-plantuml)
;;; init-plantuml.el ends here
