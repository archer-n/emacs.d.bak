;;; init-rss.el --- Rss configuration -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package elfeed
  :init
  (global-set-key (kbd "C-x w") 'elfeed)
  :custom
  (elfeed-curl-extra-arguments '("-x" "http://127.0.0.1:58591"))
  (elfeed-feeds '(
        ;; programming
        ("https://news.ycombinator.com/rss" hacker)
        ("https://www.heise.de/developer/rss/news-atom.xml" heise)
        ("https://www.reddit.com/r/programming.rss" programming)
        ("https://www.reddit.com/r/emacs.rss" emacs)

        ;; programming languages
        ("https://www.reddit.com/r/golang.rss" golang)
        ("https://www.reddit.com/r/java.rss" java)
        ("https://www.reddit.com/r/javascript.rss" javascript)
        ("https://www.reddit.com/r/typescript.rss" typescript)
        ("https://www.reddit.com/r/clojure.rss" clojure)
        ("https://www.reddit.com/r/python.rss" python)

        ;; cloud
        ("https://www.reddit.com/r/aws.rss" aws)
        ("https://www.reddit.com/r/googlecloud.rss" googlecloud)
        ("https://www.reddit.com/r/azure.rss" azure)
        ("https://www.reddit.com/r/devops.rss" devops)
        ("https://www.reddit.com/r/kubernetes.rss" kubernetes)

        ;; stats
        ("http://www.stats.gov.cn/tjsj/zxfb/rss.xml" stats-zxfb)
        ("http://www.stats.gov.cn/tjsj/sjjd/rss.xml" stats-sjjd)
        )))

(provide 'init-rss)
;;; init-rss.el ends here
