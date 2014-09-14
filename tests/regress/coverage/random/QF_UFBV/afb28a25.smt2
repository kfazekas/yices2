(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_UFBV)
(declare-fun f0 ( (_ BitVec 8) (_ BitVec 12)) (_ BitVec 14))
(declare-fun f1 ( (_ BitVec 9) (_ BitVec 7)) (_ BitVec 14))
(declare-fun p0 ( (_ BitVec 13) (_ BitVec 13)) Bool)
(declare-fun p1 ( (_ BitVec 12) (_ BitVec 10) (_ BitVec 13)) Bool)
(declare-fun v0 () (_ BitVec 3))
(declare-fun v1 () (_ BitVec 11))
(declare-fun v2 () (_ BitVec 16))
(assert (let ((e3(_ bv61612 16)))
(let ((e4 (f1 ((_ zero_extend 6) v0) ((_ extract 8 2) v2))))
(let ((e5 (ite (p0 ((_ extract 12 0) e4) ((_ sign_extend 2) v1)) (_ bv1 1) (_ bv0 1))))
(let ((e6 (f1 ((_ extract 10 2) v1) ((_ sign_extend 6) e5))))
(let ((e7 (f1 ((_ zero_extend 6) v0) ((_ zero_extend 4) v0))))
(let ((e8 (f0 ((_ zero_extend 7) e5) ((_ extract 11 0) e6))))
(let ((e9 (ite (p0 ((_ extract 13 1) e8) ((_ zero_extend 12) e5)) (_ bv1 1) (_ bv0 1))))
(let ((e10 (ite (p0 ((_ extract 12 0) e7) ((_ zero_extend 10) v0)) (_ bv1 1) (_ bv0 1))))
(let ((e11 (ite (p0 ((_ extract 12 0) e4) ((_ extract 12 0) e7)) (_ bv1 1) (_ bv0 1))))
(let ((e12 ((_ repeat 1) v2)))
(let ((e13 (ite (p1 ((_ zero_extend 1) v1) ((_ extract 9 0) e4) ((_ zero_extend 2) v1)) (_ bv1 1) (_ bv0 1))))
(let ((e14 (ite (distinct v1 ((_ zero_extend 10) e5)) (_ bv1 1) (_ bv0 1))))
(let ((e15 (ite (bvult e12 e12) (_ bv1 1) (_ bv0 1))))
(let ((e16 (bvxor ((_ zero_extend 10) e14) v1)))
(let ((e17 (bvnor e10 e9)))
(let ((e18 (bvcomp ((_ sign_extend 15) e15) v2)))
(let ((e19 (bvurem ((_ sign_extend 15) e13) e3)))
(let ((e20 (p0 ((_ sign_extend 10) v0) ((_ extract 13 1) e4))))
(let ((e21 (bvslt e13 e17)))
(let ((e22 (p1 ((_ zero_extend 11) e9) ((_ zero_extend 9) e11) ((_ extract 12 0) e19))))
(let ((e23 (bvsle ((_ sign_extend 10) e17) v1)))
(let ((e24 (bvslt e7 ((_ sign_extend 13) e9))))
(let ((e25 (= e7 e4)))
(let ((e26 (bvsge v2 ((_ sign_extend 2) e6))))
(let ((e27 (distinct ((_ zero_extend 5) v1) v2)))
(let ((e28 (bvsgt e12 ((_ sign_extend 2) e8))))
(let ((e29 (bvuge e4 ((_ zero_extend 13) e11))))
(let ((e30 (bvsgt v1 ((_ zero_extend 10) e11))))
(let ((e31 (bvuge ((_ zero_extend 13) e10) e7)))
(let ((e32 (distinct e19 e3)))
(let ((e33 (p1 ((_ sign_extend 11) e13) ((_ extract 13 4) e7) ((_ extract 12 0) e7))))
(let ((e34 (distinct ((_ sign_extend 8) v0) e16)))
(let ((e35 (= e8 ((_ sign_extend 13) e10))))
(let ((e36 (bvsle e3 ((_ sign_extend 2) e7))))
(let ((e37 (= ((_ zero_extend 15) e11) e19)))
(let ((e38 (bvugt ((_ sign_extend 15) e15) e12)))
(let ((e39 (bvsgt v0 ((_ sign_extend 2) e5))))
(let ((e40 (bvult e19 e3)))
(let ((e41 (bvult ((_ sign_extend 13) e17) e8)))
(let ((e42 (bvuge ((_ sign_extend 11) v0) e7)))
(let ((e43 (bvult e8 ((_ sign_extend 3) e16))))
(let ((e44 (bvuge e6 ((_ sign_extend 13) e13))))
(let ((e45 (bvult ((_ sign_extend 13) e13) e4)))
(let ((e46 (bvsgt e7 e6)))
(let ((e47 (p1 ((_ sign_extend 11) e13) ((_ extract 12 3) v2) ((_ sign_extend 10) v0))))
(let ((e48 (bvsge ((_ sign_extend 15) e18) e19)))
(let ((e49 (bvule e19 ((_ sign_extend 5) v1))))
(let ((e50 (bvugt e12 ((_ sign_extend 15) e15))))
(let ((e51 (bvslt ((_ zero_extend 13) v0) e19)))
(let ((e52 (bvult e19 ((_ zero_extend 2) e8))))
(let ((e53 (bvuge e9 e10)))
(let ((e54 (bvsgt e3 ((_ sign_extend 2) e7))))
(let ((e55 (= ((_ sign_extend 13) e13) e8)))
(let ((e56 (bvugt ((_ sign_extend 15) e5) e19)))
(let ((e57 (bvuge e19 e12)))
(let ((e58 (p1 ((_ zero_extend 1) e16) ((_ extract 9 0) e3) ((_ zero_extend 2) v1))))
(let ((e59 (bvuge e19 ((_ sign_extend 15) e11))))
(let ((e60 (bvule v2 ((_ zero_extend 5) v1))))
(let ((e61 (bvsle e7 ((_ sign_extend 13) e5))))
(let ((e62 (bvult e5 e9)))
(let ((e63 (p1 ((_ sign_extend 11) e10) ((_ sign_extend 9) e17) ((_ sign_extend 12) e17))))
(let ((e64 (p1 ((_ sign_extend 11) e5) ((_ zero_extend 9) e10) ((_ zero_extend 12) e5))))
(let ((e65 (bvugt v0 ((_ sign_extend 2) e18))))
(let ((e66 (bvsge ((_ sign_extend 2) e11) v0)))
(let ((e67 (bvult v2 ((_ zero_extend 15) e17))))
(let ((e68 (= e8 ((_ zero_extend 13) e15))))
(let ((e69 (bvult v2 ((_ sign_extend 15) e5))))
(let ((e70 (bvuge ((_ zero_extend 2) e6) v2)))
(let ((e71 (= ((_ sign_extend 15) e5) v2)))
(let ((e72 (bvsgt ((_ zero_extend 10) e13) v1)))
(let ((e73 (bvugt e12 ((_ sign_extend 15) e18))))
(let ((e74 (bvule e11 e17)))
(let ((e75 (bvsle e13 e15)))
(let ((e76 (bvsge v1 e16)))
(let ((e77 (bvule e6 e7)))
(let ((e78 (p1 ((_ extract 12 1) e6) ((_ extract 11 2) v2) ((_ extract 14 2) e19))))
(let ((e79 (distinct e19 ((_ sign_extend 15) e14))))
(let ((e80 (=> e39 e67)))
(let ((e81 (or e21 e46)))
(let ((e82 (not e61)))
(let ((e83 (xor e49 e31)))
(let ((e84 (= e75 e76)))
(let ((e85 (xor e83 e42)))
(let ((e86 (= e84 e79)))
(let ((e87 (and e33 e81)))
(let ((e88 (and e69 e36)))
(let ((e89 (ite e50 e52 e35)))
(let ((e90 (= e30 e32)))
(let ((e91 (xor e66 e53)))
(let ((e92 (ite e26 e60 e23)))
(let ((e93 (ite e72 e44 e25)))
(let ((e94 (or e74 e80)))
(let ((e95 (= e47 e20)))
(let ((e96 (or e27 e78)))
(let ((e97 (ite e55 e85 e51)))
(let ((e98 (and e43 e86)))
(let ((e99 (and e29 e89)))
(let ((e100 (not e70)))
(let ((e101 (= e34 e71)))
(let ((e102 (= e82 e93)))
(let ((e103 (not e94)))
(let ((e104 (or e57 e54)))
(let ((e105 (xor e58 e37)))
(let ((e106 (or e24 e96)))
(let ((e107 (=> e40 e97)))
(let ((e108 (= e45 e99)))
(let ((e109 (not e56)))
(let ((e110 (not e22)))
(let ((e111 (xor e100 e38)))
(let ((e112 (=> e62 e95)))
(let ((e113 (=> e91 e77)))
(let ((e114 (or e59 e48)))
(let ((e115 (= e73 e92)))
(let ((e116 (=> e110 e104)))
(let ((e117 (not e107)))
(let ((e118 (ite e90 e102 e65)))
(let ((e119 (not e28)))
(let ((e120 (and e109 e106)))
(let ((e121 (and e64 e68)))
(let ((e122 (ite e98 e114 e98)))
(let ((e123 (= e119 e103)))
(let ((e124 (ite e115 e108 e120)))
(let ((e125 (or e112 e111)))
(let ((e126 (xor e88 e113)))
(let ((e127 (and e41 e87)))
(let ((e128 (not e125)))
(let ((e129 (xor e118 e123)))
(let ((e130 (and e63 e116)))
(let ((e131 (not e126)))
(let ((e132 (xor e101 e101)))
(let ((e133 (or e122 e131)))
(let ((e134 (xor e129 e105)))
(let ((e135 (xor e127 e121)))
(let ((e136 (xor e135 e128)))
(let ((e137 (not e124)))
(let ((e138 (not e130)))
(let ((e139 (or e133 e137)))
(let ((e140 (ite e138 e136 e136)))
(let ((e141 (=> e117 e140)))
(let ((e142 (or e134 e141)))
(let ((e143 (ite e142 e132 e139)))
(let ((e144 (and e143 (not (= e3 (_ bv0 16))))))
e144
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
