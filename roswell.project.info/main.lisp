(uiop/package:define-package :roswell.project.info/main
                             (:nicknames :roswell.project.info)
                             (:use :roswell.project :cl) (:shadow) (:export)
                             (:intern))
(in-package :roswell.project.info/main)
;;don't edit above

(defun info (&rest r)
  (format t "Usage: type 'ros project help' for ~2%")
  (let* ((path (find-asd *default-pathname-defaults*))
         (asd (asd path)))
    (format t "name:~A~%" (getf asd :name))
    (when (getf asd :version)
      (format t "version:~A~%" (getf asd :version)))
    (when (getf asd :depends-on)
      (format t "~(~A~):~%" :depends-on)
      (dolist (i (getf asd :depends-on))
        (format t "  ~(~S~)~%" i)))
    (when (getf asd :components)
      (format t "~(~A~):~%" :components)
      (dolist (i (getf asd :components))
        (format t "  ~(~S~)~%" i)))))
