(set-logic QF_LIA)
(declare-fun x () Int)
(define-fun d () Int (div x (- 4)))
(assert (>= x (- 4 (* 4 d))))
(check-sat)
