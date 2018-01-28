(uiop/package:define-package :roswell.package.export/main
                             (:nicknames :roswell.package.export)
                             (:use :project :cl) (:shadow :export) (:export)
                             (:intern))
(in-package :roswell.package.export/main)
;;don't edit above

(defun export (r)
  (if (and (first r)
           (probe-file (first r)))
      (let ((key :export)
            (package (normalize-package (load-package (first r)))))
        (cond ((null (rest r))
               (format t "~{~(~A~%~)~}" (cdr (assoc key package))))
              ((find (second r) '("-a" "add") :test 'equal)
               (let ((elts (cdr (assoc key package))))
                 (dolist (i (nthcdr 2 r))
                   (pushnew (read-from-string (format nil ":~A" i)) elts))
                 (setf (cdr (assoc key package)) elts)
                 (save-package package (first r))
                 ))
              ((find (second r) '("-d" "rm") :test 'equal)
               (let ((elts (cdr (assoc key package))))
                 (dolist (i (nthcdr 2 r))
                   (setf elts (remove (read-from-string (format nil ":~A" i)) elts)))
                 (setf (cdr (assoc key package)) elts)
                 (save-package package (first r))))))))
