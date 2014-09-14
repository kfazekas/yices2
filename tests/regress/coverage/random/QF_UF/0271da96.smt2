(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_UF)
(declare-sort S0 0)
(declare-fun v0 () S0)
(declare-fun f0 ( S0 S0 S0) S0)
(declare-fun f1 ( S0) S0)
(declare-fun f2 ( S0 S0 S0) S0)
(declare-fun f3 ( S0 S0 S0) S0)
(declare-fun f4 ( S0) S0)
(declare-fun p0 ( S0 S0) Bool)
(declare-fun p1 ( S0 S0 S0) Bool)
(declare-fun p2 ( S0 S0) Bool)
(declare-fun p3 ( S0 S0 S0) Bool)
(declare-fun p4 ( S0) Bool)
(assert (let ((e1 (f1 v0)))
(let ((e2 (f1 e1)))
(let ((e3 (f2 e2 e1 e2)))
(let ((e4 (f1 v0)))
(let ((e5 (f4 v0)))
(let ((e6 (f0 e4 e1 e2)))
(let ((e7 (f4 e2)))
(let ((e8 (f3 v0 e3 e5)))
(let ((e9 (= e5 e6)))
(let ((e10 (p0 e6 e3)))
(let ((e11 (p4 e1)))
(let ((e12 (p1 e6 e2 e7)))
(let ((e13 (distinct e4 e2)))
(let ((e14 (p0 e7 e3)))
(let ((e15 (p2 e7 e4)))
(let ((e16 (= e8 e5)))
(let ((e17 (p2 e4 e6)))
(let ((e18 (distinct v0 e4)))
(let ((e19 (p4 e6)))
(let ((e20 (p1 e4 v0 e6)))
(let ((e21 (p1 v0 e8 e5)))
(let ((e22 (p1 e6 e5 e3)))
(let ((e23 (p3 e3 e1 e8)))
(let ((e24 (ite e12 v0 e5)))
(let ((e25 (ite e21 e7 e24)))
(let ((e26 (ite e20 e2 e6)))
(let ((e27 (ite e10 e8 e25)))
(let ((e28 (ite e22 e1 e26)))
(let ((e29 (ite e21 e26 e27)))
(let ((e30 (ite e9 e3 e24)))
(let ((e31 (ite e13 e4 e2)))
(let ((e32 (ite e21 e5 e30)))
(let ((e33 (ite e16 e8 e5)))
(let ((e34 (ite e18 e30 e6)))
(let ((e35 (ite e23 v0 e5)))
(let ((e36 (ite e16 e4 e7)))
(let ((e37 (ite e19 e32 e32)))
(let ((e38 (ite e17 e35 e24)))
(let ((e39 (ite e17 e3 e38)))
(let ((e40 (ite e14 e39 e24)))
(let ((e41 (ite e11 e8 e39)))
(let ((e42 (ite e15 e31 e29)))
(let ((e43 (p3 e27 e24 e38)))
(let ((e44 (= e5 e33)))
(let ((e45 (p4 e31)))
(let ((e46 (distinct e35 e40)))
(let ((e47 (p0 e33 e8)))
(let ((e48 (p1 e6 e38 e5)))
(let ((e49 (p2 e34 e24)))
(let ((e50 (p2 e33 e38)))
(let ((e51 (p0 e27 e4)))
(let ((e52 (p3 e40 e25 e2)))
(let ((e53 (p0 e37 e24)))
(let ((e54 (p4 e30)))
(let ((e55 (distinct v0 e2)))
(let ((e56 (= e1 e36)))
(let ((e57 (p1 e4 e30 e29)))
(let ((e58 (p0 e33 e33)))
(let ((e59 (distinct e3 e1)))
(let ((e60 (distinct e7 e36)))
(let ((e61 (p2 e5 e24)))
(let ((e62 (p4 e29)))
(let ((e63 (= e26 e34)))
(let ((e64 (= e39 e24)))
(let ((e65 (= e28 e27)))
(let ((e66 (p2 e5 e6)))
(let ((e67 (p4 e40)))
(let ((e68 (= e41 e5)))
(let ((e69 (= e32 e41)))
(let ((e70 (= e42 e38)))
(let ((e71 (and e58 e51)))
(let ((e72 (ite e50 e18 e11)))
(let ((e73 (and e63 e62)))
(let ((e74 (or e13 e45)))
(let ((e75 (and e46 e9)))
(let ((e76 (not e47)))
(let ((e77 (or e67 e65)))
(let ((e78 (or e66 e12)))
(let ((e79 (=> e43 e52)))
(let ((e80 (=> e59 e23)))
(let ((e81 (not e54)))
(let ((e82 (ite e74 e53 e55)))
(let ((e83 (ite e82 e60 e71)))
(let ((e84 (=> e15 e19)))
(let ((e85 (not e17)))
(let ((e86 (or e68 e56)))
(let ((e87 (xor e78 e80)))
(let ((e88 (= e49 e22)))
(let ((e89 (or e70 e77)))
(let ((e90 (=> e89 e73)))
(let ((e91 (and e64 e21)))
(let ((e92 (=> e57 e76)))
(let ((e93 (=> e69 e20)))
(let ((e94 (=> e61 e48)))
(let ((e95 (=> e10 e92)))
(let ((e96 (or e88 e72)))
(let ((e97 (=> e86 e85)))
(let ((e98 (or e44 e83)))
(let ((e99 (=> e96 e79)))
(let ((e100 (=> e93 e14)))
(let ((e101 (and e90 e90)))
(let ((e102 (= e95 e94)))
(let ((e103 (and e16 e91)))
(let ((e104 (xor e102 e81)))
(let ((e105 (xor e104 e98)))
(let ((e106 (xor e97 e84)))
(let ((e107 (xor e75 e106)))
(let ((e108 (xor e101 e105)))
(let ((e109 (or e99 e107)))
(let ((e110 (not e87)))
(let ((e111 (= e109 e100)))
(let ((e112 (=> e103 e110)))
(let ((e113 (=> e108 e112)))
(let ((e114 (=> e111 e111)))
(let ((e115 (=> e114 e114)))
(let ((e116 (=> e115 e115)))
(let ((e117 (and e116 e116)))
(let ((e118 (not e117)))
(let ((e119 (=> e113 e118)))
e119
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
