(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_UFBV)
(declare-fun f0 ( (_ BitVec 2)) (_ BitVec 14))
(declare-fun p0 ( (_ BitVec 8)) Bool)
(declare-fun v0 () (_ BitVec 13))
(assert (let ((e1(_ bv2859 15)))
(let ((e2(_ bv1 3)))
(let ((e3 (bvsdiv ((_ sign_extend 2) v0) e1)))
(let ((e4 (f0 ((_ extract 8 7) v0))))
(let ((e5 (bvcomp e3 e1)))
(let ((e6 (ite (p0 ((_ extract 7 0) v0)) (_ bv1 1) (_ bv0 1))))
(let ((e7 ((_ sign_extend 0) e1)))
(let ((e8 (bvudiv ((_ zero_extend 2) e5) e2)))
(let ((e9 (bvsgt e1 e1)))
(let ((e10 (p0 ((_ extract 8 1) v0))))
(let ((e11 (= e7 ((_ zero_extend 1) e4))))
(let ((e12 (bvsge e7 ((_ zero_extend 1) e4))))
(let ((e13 (bvult e5 e5)))
(let ((e14 (distinct ((_ zero_extend 14) e5) e1)))
(let ((e15 (bvslt e1 ((_ zero_extend 12) e2))))
(let ((e16 (bvuge e4 ((_ sign_extend 1) v0))))
(let ((e17 (bvsgt e1 ((_ zero_extend 12) e2))))
(let ((e18 (bvsge e3 ((_ sign_extend 14) e5))))
(let ((e19 (bvsgt ((_ sign_extend 11) e2) e4)))
(let ((e20 (bvsle ((_ zero_extend 14) e5) e3)))
(let ((e21 (distinct ((_ sign_extend 14) e5) e1)))
(let ((e22 (bvule e3 e1)))
(let ((e23 (= e4 ((_ zero_extend 11) e8))))
(let ((e24 (bvule v0 v0)))
(let ((e25 (= ((_ sign_extend 14) e5) e3)))
(let ((e26 (bvuge ((_ zero_extend 2) e6) e2)))
(let ((e27 (ite e11 e15 e21)))
(let ((e28 (not e18)))
(let ((e29 (and e23 e22)))
(let ((e30 (= e17 e9)))
(let ((e31 (= e14 e12)))
(let ((e32 (=> e29 e13)))
(let ((e33 (and e19 e28)))
(let ((e34 (xor e27 e30)))
(let ((e35 (not e16)))
(let ((e36 (= e25 e33)))
(let ((e37 (not e32)))
(let ((e38 (or e37 e34)))
(let ((e39 (ite e38 e36 e26)))
(let ((e40 (or e39 e35)))
(let ((e41 (=> e31 e31)))
(let ((e42 (xor e41 e40)))
(let ((e43 (not e24)))
(let ((e44 (= e43 e20)))
(let ((e45 (not e44)))
(let ((e46 (=> e10 e42)))
(let ((e47 (xor e45 e45)))
(let ((e48 (=> e47 e47)))
(let ((e49 (=> e46 e48)))
(let ((e50 (and e49 (not (= e2 (_ bv0 3))))))
(let ((e51 (and e50 (not (= e1 (_ bv0 15))))))
(let ((e52 (and e51 (not (= e1 (bvnot (_ bv0 15)))))))
e52
)))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
