;; -*- mode: emacs-lisp; indent-tabs-mode: nil -*-

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
  (concat (make-string rage-f-length ?f)
          (make-string rage-u-length ?u)))

(defun rage ()
  (interactive)
  (insert (rage-str)))

(defun rage-region (beg end)
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (let ((cyclic-rage (rage-str))
          (buffer-read-only nil))
      (while (re-search-forward (rx (syntax word)) end t)
        (replace-match (substring cyclic-rage 0 1))
        (setq cyclic-rage (if (eq (length cyclic-rage) 1)
                              (rage-str)
                            (substring cyclic-rage 1)))))))


(provide 'rage)
