;;; init-rss.el --- Rss configuration -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package elfeed
  :init
  (global-set-key (kbd "C-x w") 'elfeed)
  :custom
  (elfeed-curl-extra-arguments '("-x" "http://127.0.0.1:58591"))
  (elfeed-feeds '(("http://nullprogram.com/feed/" blog emacs)
                  "https://planet.emacslife.com/atom.xml"
                  ("http://tech.meituan.com/atom.xml" meituan)
                  ("http://feeds.feedburner.com/ruanyifeng" ruanyifeng)
                  ("https://blog.lilydjwg.me/feed" lily)
                  "https://inside.java/feed.xml"
                  "https://hacks.mozilla.org/feed/"
                  "https://hnrss.org/best"
                  "https://kernel.taobao.org/feed.xml"
                  "https://www.zhangxinxu.com/wordpress/feed/")))

(provide 'init-rss)
;;; init-rss.el ends here
