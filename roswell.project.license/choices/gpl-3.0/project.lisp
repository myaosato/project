;;don't edit
(let ((data '(("asd" "roswell.project-license.gpl-3.0"))))
  (dolist (n (assoc "asd" data :test 'equal))
    (funcall (read-from-string "asdf:load-asd")
             (make-pathname :defaults *load-pathname* :name n :type "asd"))))
