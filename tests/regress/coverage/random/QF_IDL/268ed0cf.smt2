(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_IDL)
(declare-fun v0 () Int)
(declare-fun v1 () Int)
(declare-fun v2 () Int)
(declare-fun v3 () Int)
(declare-fun v4 () Int)
(assert (let ((e5 3))
(let ((e6 13))
(let ((e7 6))
(let ((e8 (distinct (- v4 v3) e6)))
(let ((e9 (<= v0 v0)))
(let ((e10 (> v2 v4)))
(let ((e11 (> v0 v2)))
(let ((e12 (distinct v3 v1)))
(let ((e13 (<= (- v4 v1) (- e6))))
(let ((e14 (<= v3 v0)))
(let ((e15 (>= (- v3 v0) (- e5))))
(let ((e16 (distinct (- v0 v4) e7)))
(let ((e17 (> v1 v2)))
(let ((e18 (<= (- v1 v3) (- e7))))
(let ((e19 (>= v4 v4)))
(let ((e20 (= (- v1 v2) e6)))
(let ((e21 (distinct (- v4 v0) e5)))
(let ((e22 (distinct v0 v3)))
(let ((e23 (= (- v3 v3) (- e7))))
(let ((e24 (<= v4 v4)))
(let ((e25 (<= (- v1 v0) (- e5))))
(let ((e26 (>= v3 v3)))
(let ((e27 (< v1 v2)))
(let ((e28 (< v3 v0)))
(let ((e29 (<= v4 v1)))
(let ((e30 (= v2 v3)))
(let ((e31 (< v2 v3)))
(let ((e32 (> (- v0 v0) (- e6))))
(let ((e33 (= (- v4 v4) e5)))
(let ((e34 (xor e10 e14)))
(let ((e35 (= e12 e15)))
(let ((e36 (or e23 e9)))
(let ((e37 (=> e32 e33)))
(let ((e38 (not e13)))
(let ((e39 (not e31)))
(let ((e40 (ite e25 e22 e8)))
(let ((e41 (not e28)))
(let ((e42 (=> e17 e27)))
(let ((e43 (xor e16 e30)))
(let ((e44 (= e24 e35)))
(let ((e45 (=> e29 e26)))
(let ((e46 (not e18)))
(let ((e47 (= e40 e34)))
(let ((e48 (and e19 e47)))
(let ((e49 (not e21)))
(let ((e50 (= e49 e41)))
(let ((e51 (not e50)))
(let ((e52 (and e43 e11)))
(let ((e53 (xor e38 e52)))
(let ((e54 (=> e48 e51)))
(let ((e55 (xor e36 e44)))
(let ((e56 (not e20)))
(let ((e57 (xor e53 e53)))
(let ((e58 (and e56 e54)))
(let ((e59 (=> e42 e37)))
(let ((e60 (=> e46 e55)))
(let ((e61 (and e59 e39)))
(let ((e62 (and e45 e57)))
(let ((e63 (=> e62 e62)))
(let ((e64 (ite e63 e63 e58)))
(let ((e65 (or e60 e64)))
(let ((e66 (= e65 e61)))
e66
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
