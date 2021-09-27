;;; init-windows.el --- Working with windows within frames -*- lexical-binding: t -*-
;;; Commentary:

;; This is not about the "Windows" OS, but rather Emacs's "windows"
;; concept: these are the panels within an Emacs frame which contain
;; buffers.

;;; Code:


;; Navigate window layouts with "C-c <left>" and "C-c <right>"

(add-hook 'after-init-hook 'winner-mode)

(use-package switch-window
  :ensure t
  :bind (("C-x o" . switch-window))
  :config
  (setq-default switch-window-shortcut-style 'alphabet)
  (setq-default switch-window-timeout nil))

(defun split-window-func-with-other-buffer (split-function)
  (lambda (&optional arg)
    "Split this window and switch to the new window unless ARG is provided."
    (interactive "P")
    (funcall split-function)
    (let ((target-window (next-window)))
      (set-window-buffer target-window (other-buffer))
      (unless arg
        (select-window target-window)))))
(global-set-key (kbd "C-x 2") (split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key (kbd "C-x 3") (split-window-func-with-other-buffer 'split-window-horizontally))

(unless (memq window-system '(nt w32))
  (use-package windswap
    :init
    (add-hook 'after-init-hook (apply-partially 'windmove-default-keybindings 'control))
    (add-hook 'after-init-hook (apply-partially 'windswap-default-keybindings 'shift 'control))))

(provide 'init-windows)
;;; init-windows.el ends here
