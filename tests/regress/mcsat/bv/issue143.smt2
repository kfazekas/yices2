(set-logic QF_BV)
(declare-fun x0 () (_ BitVec 2))
(declare-fun x1 () (_ BitVec 3))
(assert (let ((e4 (_ bv201 8))) (let ((e7 (concat x1 x0))) (let ((e14 (bvadd ((_ zero_extend 3) e7) e4))) (let ((e45 (distinct e14 ((_ zero_extend 6) x0)))) (let ((e66 (=> e45 false))) (let ((e88 (not e66))) (let ((e92 (xor true e88))) e92))))))))
(check-sat)