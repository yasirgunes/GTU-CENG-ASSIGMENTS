;(format t "Hello, World!~%")  ; print to standard output

; define a global variable
;; (defvar *my-global-var* 42)
;; (format t "The value of *my-global-var* is ~a.~%" *my-global-var*)

; define a global variable and take user input and assign to that variable
;; (defvar *my-global-var* (read))
;; (format t "The value of *my-global-var* is ~a.~%" *my-global-var*)

; setq is for assigning values to variables.
;; (defvar *deneme* 0)
;; (setq *deneme* 42)
;; (format t "~a. ~%" *deneme*)

; defining functions and calling them
;; (defun hello-you (*name*)
;;     (format t "Hello, ~a!~%" *name*)
;; )
;; (hello-you "yasir")

; comparison
;; (equal 1 1) ; = T
;; (equal 1 2) ; = NIL
;; (equalp 1 1.0) ; = T
;; equal is for deep comparison
;; equalp is for shallow comparison

; if statement
;; (defvar *age* 18)
;; (if (>= *age* 18)
;;     (format t "You can vote!~%") ; if
;;     (format t "You can't vote!~%") ; else
;; )
;; (if (and (>= *age* 18) (<= *age* 21))
;;     (format t "You can vote, but you can't drink!~%")
;;     (format t "You can vote and drink!~%")
;; )
;; (if (not (and (>= *age* 18) (<= *age* 21)))
;;     (format t "You can vote and drink!~%")
;;     (format t "You can vote, but you can't drink!~%")
;; )

; progn is for executing multiple statements
;; (defvar *num* 2)
;; (if (equal *num* 1)
;;     (progn
;;         (format t "The number is 1.~%")
;;         (format t "The number is 1.~%")
;;         (format t "The number is 1.~%")
;;     )
;;     (progn
;;         (format t "The number is not 1.~%")
;;         (format t "The number is not 1.~%")
;;         (format t "The number is not 1.~%")
;;     )
;; )

; when and unless
;; (defvar *age* 18)
;; (when (>= *age* 18)
;;     (format t "You can vote!~%")
;;     (format t "You can drink!~%")
;;     (format t "You can drive!~%")
;;     (format t "You can marry!~%")
;; )

;; (unless (>= *age* 18)
;;     (format t "You can't vote!~%")
;;     (format t "You can't drink!~%")
;;     (format t "You can't drive!~%")
;;     (format t "You can't marry!~%")
;; )

; cond is for if else if else if else statements together.
;; (defvar *money* 10000)
;; (cond ((< money 1000) ;if
;;         (format t "You are poor!~%"))
;;       ((< money 10000) ;else if
;;         (format t "You are middle class!~%"))
;;       ((< money 100000) ;else
;;         (format t "You are rich!~%")))

; for loop
;; (loop for x from 1 to 10
;;     do (format t "~a ~%" x)
;; )

; while loop
;; (defvar x 1)
;; (loop 
;;     (format t "~d ~%" x)
;;     (setq x (+ x 1))
;;     (when (> x 10)
;;         (return)
;;     )
;; )

;traverse a list
;; (defvar my_list '(1 2 3 4 5)) ; what is ' ? => quote operator (it means that don't evaluate this)
;; (loop for x in my_list
;;     do (format t "~d ~%" x)
;; )

; dotimes
;; (dotimes (x 10) ; from 0 to 9
;;     (format t "~d ~%" x)
;; )


;; ; cons and list
;; (cons 1 '(2, 8, 13)) ; (1 2 8 13)
;; (list 2 3 4 5) ; (2 3 4 5)

; check if it is a list
;; (listp '(1 2 3 4 5)) ; => T

; check if the element is in list
;; (print (member 3 '(2 54 14 23 78))) => nil

; create a list push and append
;; (defparameter *my_list* '(1 5 3 7 9))
;; (push 2 *my_list*) ; => (2 1 5 3 7 9)
;; (append *my_list* '(2 3 4 5)) ; => (1 5 3 7 9 2 3 4 5)
;; (print (nth 2 *my_list*)) ; => 5

; some list stuff
;; (defvar superman (list :name "Superman" :secret-id "Clark Kent"))
;; (defvar *hero_list* nil)
;; (push superman *hero_list*)
;; (dolist (hero *hero_list*) ; Traverse all the elements in the *hero_list* as hero.
;;     (format t "~a ~%" hero)
;; )