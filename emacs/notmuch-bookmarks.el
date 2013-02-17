(require 'notmuch)

(defcustom notmuch-bookmarks
  '(("inbox" . ?i))
  "Notmuch bookmarks."
  :type '(alist :key-type (string) :value-type (character))
  :group 'notmuch)

(defun notmuch-jump-bookmark ()
  (interactive)
  (when (and notmuch-bookmarks notmuch-saved-searches)
    (let* ((prompt "Bookmark: ")
	   (bnames
	    (mapconcat
	     (lambda (item)
	       (concat "["
		       (propertize (make-string 1 (cdr item))
				   'face 'bold)
		       "]"
		       (car item)))
	     notmuch-bookmarks ", "))
	   (kar (read-char (concat prompt bnames)))
	   (saved-search (car-safe (find-if (lambda (item) (= kar (cdr item)))
					    notmuch-bookmarks)))
	   (query (when saved-search
		    (cdr-safe (assoc saved-search notmuch-saved-searches)))))
      (when query
	(notmuch-search query)))))

(provide 'notmuch-bookmarks)
