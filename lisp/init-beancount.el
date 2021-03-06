;;; init-beancount.el --- Beancount configure -*- lexical-binding: t -*-
;;; Commentary: Emacs setup for Ledger.
;;; Code:

(require 'beancount)
(require 'compile)
;; Automatically open .beancount files in beancount-mode.
(add-to-list 'auto-mode-alist '("\\.beancount$" . beancount-mode))

;; Support parsing Python logging errors, with a suitable logging.basicConfig()
;; format.
(unless (assq 'python-logging compilation-error-regexp-alist-alist)

  (add-to-list
   'compilation-error-regexp-alist-alist
   '(python-logging "\\(ERROR\\|WARNING\\):\\s-*\\([^:]+\\):\\([0-9]+\\)\\s-*:" 2 3))

  (add-to-list
   'compilation-error-regexp-alist 'python-logging)
  )


;; Experimental: Bind a key to reformat the entire file using bean-format.
(defun beancount-format-file ()
  (interactive)
  (let ((line-no (line-number-at-pos)))
      (call-process-region (point-min) (point-max) "bean-format" t (current-buffer))
      (goto-line line-no)
      (recenter)
      ))

;; Make sure we don't accidentally pick up ;;; as headers. Use org section headers only.
(setq beancount-outline-regexp "\\(\\*+\\)")

;; Automatically enable outline-mode.
(add-hook 'beancount-mode-hook #'outline-minor-mode)

;; Add movement between sections.
(define-key beancount-mode-map [(control c)(control n)] #'outline-next-visible-heading)
(define-key beancount-mode-map [(control c)(control p)] #'outline-previous-visible-heading)
(define-key beancount-mode-map [(control c)(control u)] #'outline-up-heading)

;; Disable auto-indent.

(defun disable-electric-indent ()
  (setq-local electric-indent-chars nil))
(add-hook 'beancount-mode-hook #'disable-electric-indent)

;; `beancount-number-alignment-column`. Setting it to 0 will cause the
;; alignment column to be determined from file content.  Postings in
;; transactions are indented with `beancount-transaction-indent` spaces.


;; Register support for a 'beancount-account thing for (thing-at-point).
(put 'beancount-account 'bounds-of-thing-at-point
     (lambda ()
       (let ((thing (thing-at-point-looking-at
		     beancount-account-regexp 500)))
         (if thing
             (let ((beginning (match-beginning 0))
                   (end (match-end 0)))
               (cons beginning end))))))

(defadvice shell-quote-argument (around dont-quote-already-quoted-args activate)
  "Avoid quoting argument if it's already quoted."
  (let ((arg (ad-get-arg 0)))
    (setq ad-return-value
          (if (or (string-match "\".*\"$" arg)
                  (string-match "\'.*\'$" arg))
              arg ad-do-it))))

(defvar beancount-journal-command
  (concat
   "select date, flag, maxwidth(description, 80), position, balance "
   "where account = '%s'"))

(defun beancount-query-journal-at-point ()
  "Run a journal command for the account at point."
  (interactive)
  (let* ((account (thing-at-point 'beancount-account))
         (sql (concat "\"" (format beancount-journal-command account) "\"")))
    (beancount--run beancount-query-program
                    (file-relative-name buffer-file-name)
                    sql)))

(define-key beancount-mode-map [(control c)(j)] #'beancount-query-journal-at-point)
(define-key beancount-mode-map [(control c)(control f)] #'beancount-format-file)

(provide 'init-beancount)
;;; init-beancount.el ends here
