(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_BV)
(declare-fun v0 () (_ BitVec 2))
(declare-fun v1 () (_ BitVec 10))
(declare-fun v2 () (_ BitVec 7))
(declare-fun v3 () (_ BitVec 1))
(declare-fun v4 () (_ BitVec 8))
(assert (let ((e5(_ bv2 6)))
(let ((e6 (concat v2 v2)))
(let ((e7 (bvadd v4 ((_ sign_extend 2) e5))))
(let ((e8 (bvneg e6)))
(let ((e9 ((_ extract 0 0) v3)))
(let ((e10 (bvor e5 ((_ sign_extend 5) e9))))
(let ((e11 (bvsrem ((_ sign_extend 2) e7) v1)))
(let ((e12 (bvashr ((_ zero_extend 8) e10) e8)))
(let ((e13 (ite (bvugt e6 ((_ sign_extend 4) v1)) (_ bv1 1) (_ bv0 1))))
(let ((e14 (ite (bvugt v1 e11) (_ bv1 1) (_ bv0 1))))
(let ((e15 (bvnot e12)))
(let ((e16 (bvnand e7 ((_ zero_extend 7) v3))))
(let ((e17 (bvsub e8 e12)))
(let ((e18 (ite (= ((_ zero_extend 2) e10) v4) (_ bv1 1) (_ bv0 1))))
(let ((e19 (bvshl e17 ((_ sign_extend 8) e10))))
(let ((e20 (bvlshr ((_ zero_extend 6) v3) v2)))
(let ((e21 (bvsrem ((_ zero_extend 6) e7) e6)))
(let ((e22 ((_ zero_extend 6) e14)))
(let ((e23 (ite (bvsgt v2 e22) (_ bv1 1) (_ bv0 1))))
(let ((e24 (bvashr e22 ((_ sign_extend 6) v3))))
(let ((e25 ((_ repeat 2) e22)))
(let ((e26 (bvor e16 ((_ sign_extend 6) v0))))
(let ((e27 (bvult ((_ zero_extend 1) e18) v0)))
(let ((e28 (= e26 v4)))
(let ((e29 (bvsle e10 ((_ sign_extend 5) e14))))
(let ((e30 (bvslt ((_ sign_extend 5) e9) e10)))
(let ((e31 (distinct e12 ((_ zero_extend 7) e22))))
(let ((e32 (bvule ((_ zero_extend 6) e26) e15)))
(let ((e33 (bvult ((_ zero_extend 6) v0) e16)))
(let ((e34 (bvslt e21 ((_ zero_extend 13) e9))))
(let ((e35 (bvuge e11 ((_ zero_extend 2) e7))))
(let ((e36 (bvslt ((_ sign_extend 4) e11) e12)))
(let ((e37 (bvugt v1 ((_ sign_extend 9) e18))))
(let ((e38 (bvsle ((_ sign_extend 3) e20) e11)))
(let ((e39 (= e17 ((_ sign_extend 8) e5))))
(let ((e40 (distinct ((_ sign_extend 7) e22) e19)))
(let ((e41 (bvsle ((_ sign_extend 4) v0) e10)))
(let ((e42 (bvsgt e13 e13)))
(let ((e43 (bvuge ((_ sign_extend 7) e23) e26)))
(let ((e44 (= ((_ zero_extend 13) e13) e15)))
(let ((e45 (bvult v1 ((_ zero_extend 9) e18))))
(let ((e46 (bvult ((_ zero_extend 7) e20) e15)))
(let ((e47 (bvsge e8 e25)))
(let ((e48 (bvugt ((_ sign_extend 4) v1) e21)))
(let ((e49 (bvult e25 ((_ zero_extend 8) e5))))
(let ((e50 (= ((_ sign_extend 13) v3) e6)))
(let ((e51 (bvsgt ((_ sign_extend 13) e9) e17)))
(let ((e52 (distinct e25 ((_ sign_extend 6) e26))))
(let ((e53 (bvugt e11 ((_ sign_extend 4) e5))))
(let ((e54 (= e21 ((_ sign_extend 8) e10))))
(let ((e55 (bvule e17 ((_ sign_extend 6) v4))))
(let ((e56 (distinct ((_ sign_extend 6) e23) v2)))
(let ((e57 (bvsgt e12 ((_ sign_extend 8) e10))))
(let ((e58 (distinct e8 e6)))
(let ((e59 (distinct e16 e16)))
(let ((e60 (bvsle ((_ zero_extend 7) e13) e16)))
(let ((e61 (distinct e8 ((_ zero_extend 6) e16))))
(let ((e62 (bvsge ((_ zero_extend 6) e26) e25)))
(let ((e63 (bvult e19 e17)))
(let ((e64 (bvugt e5 ((_ zero_extend 5) e23))))
(let ((e65 (bvsle ((_ zero_extend 13) e23) e17)))
(let ((e66 (bvsge e12 e21)))
(let ((e67 (bvuge ((_ sign_extend 2) e10) e26)))
(let ((e68 (= ((_ sign_extend 1) e5) e22)))
(let ((e69 (bvule e25 e6)))
(let ((e70 (bvslt e16 ((_ sign_extend 2) e5))))
(let ((e71 (bvugt e13 e9)))
(let ((e72 (= ((_ zero_extend 6) v4) e12)))
(let ((e73 (bvuge ((_ zero_extend 4) v1) e12)))
(let ((e74 (bvugt ((_ zero_extend 6) e16) e19)))
(let ((e75 (bvugt ((_ sign_extend 1) e22) e26)))
(let ((e76 (bvslt e6 ((_ zero_extend 6) v4))))
(let ((e77 (bvugt e10 ((_ zero_extend 4) v0))))
(let ((e78 (bvuge e17 ((_ sign_extend 12) v0))))
(let ((e79 (bvsle e13 v3)))
(let ((e80 (bvule e24 ((_ sign_extend 5) v0))))
(let ((e81 (or e42 e33)))
(let ((e82 (= e78 e67)))
(let ((e83 (= e28 e74)))
(let ((e84 (not e56)))
(let ((e85 (=> e44 e80)))
(let ((e86 (= e52 e65)))
(let ((e87 (xor e82 e68)))
(let ((e88 (xor e69 e87)))
(let ((e89 (not e27)))
(let ((e90 (ite e53 e37 e62)))
(let ((e91 (= e36 e76)))
(let ((e92 (xor e64 e79)))
(let ((e93 (ite e49 e30 e66)))
(let ((e94 (=> e32 e43)))
(let ((e95 (ite e92 e63 e40)))
(let ((e96 (= e46 e81)))
(let ((e97 (ite e60 e58 e88)))
(let ((e98 (= e48 e85)))
(let ((e99 (and e96 e83)))
(let ((e100 (= e98 e89)))
(let ((e101 (not e31)))
(let ((e102 (and e59 e86)))
(let ((e103 (and e29 e91)))
(let ((e104 (ite e57 e73 e75)))
(let ((e105 (ite e95 e77 e84)))
(let ((e106 (or e41 e61)))
(let ((e107 (or e55 e93)))
(let ((e108 (or e54 e70)))
(let ((e109 (not e39)))
(let ((e110 (and e47 e103)))
(let ((e111 (=> e35 e109)))
(let ((e112 (= e102 e107)))
(let ((e113 (and e112 e111)))
(let ((e114 (= e97 e100)))
(let ((e115 (= e110 e34)))
(let ((e116 (ite e113 e90 e115)))
(let ((e117 (ite e116 e114 e99)))
(let ((e118 (=> e105 e104)))
(let ((e119 (or e118 e118)))
(let ((e120 (and e45 e108)))
(let ((e121 (not e51)))
(let ((e122 (=> e117 e120)))
(let ((e123 (xor e38 e101)))
(let ((e124 (ite e72 e71 e72)))
(let ((e125 (and e94 e119)))
(let ((e126 (and e123 e125)))
(let ((e127 (ite e126 e124 e50)))
(let ((e128 (or e121 e121)))
(let ((e129 (not e128)))
(let ((e130 (= e127 e129)))
(let ((e131 (=> e122 e130)))
(let ((e132 (xor e131 e106)))
(let ((e133 (and e132 (not (= v1 (_ bv0 10))))))
(let ((e134 (and e133 (not (= v1 (bvnot (_ bv0 10)))))))
(let ((e135 (and e134 (not (= e6 (_ bv0 14))))))
(let ((e136 (and e135 (not (= e6 (bvnot (_ bv0 14)))))))
e136
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
