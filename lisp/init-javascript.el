;;; init-javascript.el --- Support for Javascript and derivatives -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(use-package json-mode)

(setq-default js-indent-level 2)
(setq-default js2-bounce-indent-p nil)
;; In Emacs >= 25, the following is an alias for js-indent-level anyway
(setq-default js2-basic-offset 2)

(defun eslint-fix-current-file ()
  (interactive)
  (when (fboundp 'projectile-mode)
    (projectile-with-default-dir (projectile-acquire-root)
      (save-excursion
        (let ((command (concat "npx eslint --fix " (buffer-file-name))))
          (message command)
          (shell-command command))
        (revert-buffer t t)))))

(with-eval-after-load 'js
    (define-key js-mode-map (kbd "M-.") nil)
    (define-key js-mode-map (kbd "C-j") 'c-indent-new-comment-line)
    (define-key js-mode-map (kbd "C-c C-f") 'eslint-fix-current-file))

(use-package typescript-mode
  :config
  (setq-default typescript-indent-level 2)
  :bind (:map typescript-mode-map
              ("C-c C-f" . 'eslint-fix-current-file)
              ("C-j" . 'c-indent-new-comment-line)))

(use-package add-node-modules-path
  :hook (typescript-mode js-mode))

(provide 'init-javascript)
;;; init-javascript.el ends here
