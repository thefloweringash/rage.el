(defgroup rage nil
  "Rage controlling variables")

(defcustom rage-f-length 7
  "Number of 'f' characters in a rage"
  :type '(integer)
  :group 'rage)

(defcustom rage-u-length 12
  "Number of 'u' characters in a rage"
  :type '(integer)
  :group 'rage)

(defun rage-str ()
  (concat (make-string rage-f-length ?F)
	  (make-string rage-u-length ?U)))

(defun rage ()
  (interactive)
  (insert (rage-str)))

(defun rage-region (beg end)
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (let ((cyclic-rage (rage-str)))
      (while (re-search-forward (rx (syntax word)) end t)
	(goto-char (match-beginning 0))
	(delete-char 1)
	(insert (substring cyclic-rage 0 1))
	(setq cyclic-rage (if (eq (length cyclic-rage) 1)
			      (rage-str)
			    (substring cyclic-rage 1)))))))


(provide 'rage)