(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_UFBV)
(declare-fun f0 ( (_ BitVec 15) (_ BitVec 16)) (_ BitVec 14))
(declare-fun p0 ( (_ BitVec 2) (_ BitVec 13)) Bool)
(declare-fun p1 ( (_ BitVec 11) (_ BitVec 5) (_ BitVec 10)) Bool)
(declare-fun v0 () (_ BitVec 3))
(declare-fun v1 () (_ BitVec 5))
(declare-fun v2 () (_ BitVec 16))
(declare-fun v3 () (_ BitVec 4))
(declare-fun v4 () (_ BitVec 15))
(assert (let ((e5(_ bv13926 14)))
(let ((e6(_ bv3700 13)))
(let ((e7 (ite (p0 ((_ extract 4 3) v1) e6) (_ bv1 1) (_ bv0 1))))
(let ((e8 (f0 ((_ zero_extend 11) v3) ((_ sign_extend 12) v3))))
(let ((e9 ((_ zero_extend 2) e8)))
(let ((e10 ((_ repeat 4) e7)))
(let ((e11 ((_ rotate_right 2) e10)))
(let ((e12 ((_ extract 1 1) v1)))
(let ((e13 (bvnot v0)))
(let ((e14 (ite (bvule v2 ((_ sign_extend 11) v1)) (_ bv1 1) (_ bv0 1))))
(let ((e15 (ite (p1 ((_ extract 14 4) v2) ((_ sign_extend 4) e12) ((_ extract 10 1) e6)) (_ bv1 1) (_ bv0 1))))
(let ((e16 ((_ zero_extend 0) e9)))
(let ((e17 (bvcomp e10 ((_ zero_extend 3) e14))))
(let ((e18 (bvshl e8 ((_ zero_extend 13) e17))))
(let ((e19 (ite (bvult e11 e11) (_ bv1 1) (_ bv0 1))))
(let ((e20 (bvudiv ((_ sign_extend 13) e15) e18)))
(let ((e21 (ite (distinct e18 ((_ zero_extend 10) e11)) (_ bv1 1) (_ bv0 1))))
(let ((e22 (bvmul ((_ sign_extend 3) e6) e16)))
(let ((e23 (bvsub e19 e12)))
(let ((e24 (bvmul e22 ((_ sign_extend 12) v3))))
(let ((e25 (ite (bvugt ((_ zero_extend 15) e12) e24) (_ bv1 1) (_ bv0 1))))
(let ((e26 (ite (= (_ bv1 1) ((_ extract 8 8) e5)) e9 ((_ zero_extend 15) e17))))
(let ((e27 (concat e10 e12)))
(let ((e28 (bvnot e9)))
(let ((e29 (f0 ((_ extract 15 1) e22) ((_ sign_extend 15) e14))))
(let ((e30 (bvurem ((_ sign_extend 3) e14) v3)))
(let ((e31 (ite (bvuge ((_ zero_extend 11) e27) e16) (_ bv1 1) (_ bv0 1))))
(let ((e32 (ite (bvsgt v2 ((_ sign_extend 12) e30)) (_ bv1 1) (_ bv0 1))))
(let ((e33 (bvshl e5 ((_ zero_extend 13) e31))))
(let ((e34 (bvudiv e15 e32)))
(let ((e35 ((_ repeat 1) e29)))
(let ((e36 (ite (p0 ((_ extract 13 12) e18) ((_ extract 12 0) v2)) (_ bv1 1) (_ bv0 1))))
(let ((e37 (ite (bvule ((_ sign_extend 13) e25) e18) (_ bv1 1) (_ bv0 1))))
(let ((e38 (ite (bvsge e9 ((_ sign_extend 11) e27)) (_ bv1 1) (_ bv0 1))))
(let ((e39 (bvashr e8 e35)))
(let ((e40 ((_ rotate_right 0) e10)))
(let ((e41 (ite (bvule ((_ zero_extend 15) e34) e16) (_ bv1 1) (_ bv0 1))))
(let ((e42 ((_ sign_extend 9) e41)))
(let ((e43 (bvmul e9 e24)))
(let ((e44 (ite (p1 ((_ extract 11 1) e33) ((_ extract 6 2) e9) ((_ sign_extend 6) e40)) (_ bv1 1) (_ bv0 1))))
(let ((e45 (bvnand v2 ((_ zero_extend 15) e15))))
(let ((e46 ((_ zero_extend 13) e38)))
(let ((e47 (bvlshr e38 e21)))
(let ((e48 (bvadd ((_ zero_extend 1) v4) e16)))
(let ((e49 (p0 ((_ zero_extend 1) e38) ((_ sign_extend 12) e25))))
(let ((e50 (bvult e24 ((_ sign_extend 12) e11))))
(let ((e51 (p1 ((_ sign_extend 10) e47) ((_ sign_extend 4) e32) ((_ zero_extend 7) v0))))
(let ((e52 (bvsle e27 ((_ sign_extend 1) v3))))
(let ((e53 (p0 ((_ extract 1 0) e10) ((_ zero_extend 12) e12))))
(let ((e54 (bvsge e39 ((_ zero_extend 10) e40))))
(let ((e55 (bvsgt e43 ((_ zero_extend 15) e47))))
(let ((e56 (p0 ((_ sign_extend 1) e37) ((_ sign_extend 8) v1))))
(let ((e57 (p1 ((_ sign_extend 10) e34) ((_ zero_extend 4) e21) ((_ zero_extend 6) e10))))
(let ((e58 (bvslt e45 ((_ sign_extend 15) e37))))
(let ((e59 (p1 ((_ extract 15 5) e26) ((_ sign_extend 1) e10) ((_ sign_extend 5) e27))))
(let ((e60 (bvult ((_ sign_extend 3) e17) v3)))
(let ((e61 (bvugt e32 e25)))
(let ((e62 (= e13 ((_ zero_extend 2) e21))))
(let ((e63 (distinct e44 e25)))
(let ((e64 (bvuge e8 ((_ zero_extend 11) v0))))
(let ((e65 (bvsgt e41 e12)))
(let ((e66 (bvsle ((_ sign_extend 15) e44) e9)))
(let ((e67 (bvslt e47 e34)))
(let ((e68 (= e13 ((_ zero_extend 2) e25))))
(let ((e69 (bvsle ((_ sign_extend 15) e34) e48)))
(let ((e70 (= e39 e5)))
(let ((e71 (bvslt v0 ((_ sign_extend 2) e38))))
(let ((e72 (bvuge ((_ sign_extend 13) e25) e46)))
(let ((e73 (bvule ((_ sign_extend 2) e18) e48)))
(let ((e74 (bvsle ((_ sign_extend 11) v1) e43)))
(let ((e75 (distinct ((_ sign_extend 5) e27) e42)))
(let ((e76 (distinct ((_ sign_extend 15) e14) e22)))
(let ((e77 (bvult e10 ((_ zero_extend 3) e37))))
(let ((e78 (bvuge v2 ((_ sign_extend 15) e15))))
(let ((e79 (bvule e6 ((_ sign_extend 12) e14))))
(let ((e80 (bvult e24 ((_ sign_extend 15) e17))))
(let ((e81 (= e27 ((_ sign_extend 2) v0))))
(let ((e82 (bvsge e7 e21)))
(let ((e83 (bvule e18 ((_ zero_extend 13) e44))))
(let ((e84 (bvugt ((_ zero_extend 9) e7) e42)))
(let ((e85 (bvsle e20 ((_ zero_extend 13) e15))))
(let ((e86 (bvugt ((_ zero_extend 11) e13) e18)))
(let ((e87 (bvult e43 ((_ zero_extend 15) e21))))
(let ((e88 (bvsle ((_ zero_extend 11) v0) e39)))
(let ((e89 (bvule e11 ((_ sign_extend 3) e47))))
(let ((e90 (distinct e43 ((_ sign_extend 15) e31))))
(let ((e91 (bvule e8 ((_ zero_extend 10) e10))))
(let ((e92 (bvugt e14 e17)))
(let ((e93 (bvsge e34 e7)))
(let ((e94 (bvsgt ((_ sign_extend 15) e14) e24)))
(let ((e95 (bvule ((_ zero_extend 13) e14) e5)))
(let ((e96 (bvugt e27 ((_ zero_extend 4) e7))))
(let ((e97 (p1 ((_ extract 13 3) e8) ((_ zero_extend 4) e41) ((_ extract 15 6) e16))))
(let ((e98 (distinct ((_ sign_extend 15) e36) e43)))
(let ((e99 (bvsge ((_ sign_extend 2) e18) e26)))
(let ((e100 (bvule v4 ((_ zero_extend 1) e8))))
(let ((e101 (bvuge e33 ((_ zero_extend 10) v3))))
(let ((e102 (bvsle e5 ((_ zero_extend 4) e42))))
(let ((e103 (distinct e38 e15)))
(let ((e104 (bvuge e43 ((_ sign_extend 2) e5))))
(let ((e105 (bvsle e40 ((_ sign_extend 1) e13))))
(let ((e106 (bvugt e23 e47)))
(let ((e107 (bvult ((_ zero_extend 6) e11) e42)))
(let ((e108 (bvsgt ((_ zero_extend 6) e42) e26)))
(let ((e109 (bvult v0 ((_ zero_extend 2) e38))))
(let ((e110 (bvsle ((_ zero_extend 2) e7) v0)))
(let ((e111 (bvugt ((_ zero_extend 13) e41) e29)))
(let ((e112 (bvsgt e48 ((_ zero_extend 2) e33))))
(let ((e113 (p1 ((_ extract 12 2) e43) v1 ((_ sign_extend 5) v1))))
(let ((e114 (bvsge ((_ zero_extend 13) e13) e43)))
(let ((e115 (bvsle ((_ sign_extend 1) e13) e40)))
(let ((e116 (bvsgt e32 e12)))
(let ((e117 (= ((_ zero_extend 1) e29) v4)))
(let ((e118 (= e45 ((_ zero_extend 11) v1))))
(let ((e119 (bvsgt ((_ zero_extend 3) e7) e30)))
(let ((e120 (p1 ((_ zero_extend 10) e23) ((_ extract 9 5) e20) ((_ extract 10 1) e5))))
(let ((e121 (bvsge e32 e44)))
(let ((e122 (= e45 ((_ zero_extend 12) e10))))
(let ((e123 (bvult ((_ sign_extend 4) e14) v1)))
(let ((e124 (bvuge ((_ sign_extend 10) e40) e39)))
(let ((e125 (bvule e16 ((_ sign_extend 3) e6))))
(let ((e126 (bvsge e41 e37)))
(let ((e127 (bvsgt e14 e15)))
(let ((e128 (distinct ((_ sign_extend 11) e27) e24)))
(let ((e129 (bvsge e40 ((_ sign_extend 3) e15))))
(let ((e130 (bvsgt ((_ zero_extend 3) e19) e30)))
(let ((e131 (bvuge e8 ((_ sign_extend 13) e31))))
(let ((e132 (bvsge ((_ zero_extend 2) e33) e22)))
(let ((e133 (distinct e34 e21)))
(let ((e134 (bvugt v2 ((_ zero_extend 15) e32))))
(let ((e135 (bvsle ((_ zero_extend 12) e10) e26)))
(let ((e136 (p1 ((_ extract 13 3) e24) ((_ sign_extend 4) e7) ((_ sign_extend 6) e10))))
(let ((e137 (bvsge e20 ((_ sign_extend 10) e10))))
(let ((e138 (p1 ((_ zero_extend 10) e19) ((_ zero_extend 4) e7) ((_ sign_extend 6) e11))))
(let ((e139 (= ((_ sign_extend 13) e23) e46)))
(let ((e140 (= e13 ((_ zero_extend 2) e21))))
(let ((e141 (bvslt e43 ((_ sign_extend 2) e46))))
(let ((e142 (bvule ((_ sign_extend 3) e7) e30)))
(let ((e143 (= e20 ((_ zero_extend 13) e7))))
(let ((e144 (bvsge v3 ((_ sign_extend 3) e19))))
(let ((e145 (= e40 ((_ zero_extend 3) e37))))
(let ((e146 (bvslt ((_ zero_extend 15) e41) e43)))
(let ((e147 (bvule ((_ sign_extend 15) e31) e22)))
(let ((e148 (bvsgt e10 ((_ zero_extend 3) e37))))
(let ((e149 (bvule ((_ sign_extend 4) e32) e27)))
(let ((e150 (bvsle ((_ sign_extend 3) e34) v3)))
(let ((e151 (= e28 ((_ sign_extend 6) e42))))
(let ((e152 (distinct ((_ zero_extend 3) e12) e10)))
(let ((e153 (bvsgt e42 e42)))
(let ((e154 (bvugt e7 e36)))
(let ((e155 (p0 ((_ extract 5 4) e35) ((_ extract 12 0) v2))))
(let ((e156 (= e128 e54)))
(let ((e157 (not e151)))
(let ((e158 (not e123)))
(let ((e159 (xor e130 e68)))
(let ((e160 (=> e132 e150)))
(let ((e161 (=> e60 e160)))
(let ((e162 (=> e108 e140)))
(let ((e163 (or e71 e143)))
(let ((e164 (xor e95 e147)))
(let ((e165 (xor e145 e98)))
(let ((e166 (or e126 e101)))
(let ((e167 (xor e83 e67)))
(let ((e168 (not e133)))
(let ((e169 (not e149)))
(let ((e170 (and e141 e70)))
(let ((e171 (or e111 e168)))
(let ((e172 (xor e53 e114)))
(let ((e173 (= e56 e148)))
(let ((e174 (not e52)))
(let ((e175 (or e62 e65)))
(let ((e176 (and e80 e137)))
(let ((e177 (ite e125 e115 e105)))
(let ((e178 (xor e121 e118)))
(let ((e179 (or e84 e146)))
(let ((e180 (and e142 e58)))
(let ((e181 (=> e179 e96)))
(let ((e182 (=> e90 e129)))
(let ((e183 (ite e104 e81 e88)))
(let ((e184 (or e49 e139)))
(let ((e185 (not e87)))
(let ((e186 (= e103 e167)))
(let ((e187 (xor e156 e73)))
(let ((e188 (and e91 e186)))
(let ((e189 (ite e86 e92 e127)))
(let ((e190 (or e176 e164)))
(let ((e191 (or e166 e178)))
(let ((e192 (or e106 e106)))
(let ((e193 (and e93 e79)))
(let ((e194 (=> e122 e189)))
(let ((e195 (not e50)))
(let ((e196 (xor e78 e55)))
(let ((e197 (xor e99 e192)))
(let ((e198 (=> e187 e135)))
(let ((e199 (= e153 e161)))
(let ((e200 (=> e75 e57)))
(let ((e201 (=> e124 e183)))
(let ((e202 (not e198)))
(let ((e203 (ite e74 e59 e100)))
(let ((e204 (=> e169 e94)))
(let ((e205 (xor e191 e188)))
(let ((e206 (= e163 e174)))
(let ((e207 (xor e159 e159)))
(let ((e208 (=> e162 e154)))
(let ((e209 (ite e184 e172 e175)))
(let ((e210 (or e64 e200)))
(let ((e211 (and e157 e144)))
(let ((e212 (= e196 e131)))
(let ((e213 (= e102 e171)))
(let ((e214 (=> e185 e138)))
(let ((e215 (= e158 e107)))
(let ((e216 (xor e117 e134)))
(let ((e217 (not e82)))
(let ((e218 (ite e173 e165 e97)))
(let ((e219 (xor e208 e66)))
(let ((e220 (and e195 e190)))
(let ((e221 (and e136 e119)))
(let ((e222 (or e214 e109)))
(let ((e223 (or e113 e213)))
(let ((e224 (= e120 e218)))
(let ((e225 (xor e170 e204)))
(let ((e226 (or e194 e202)))
(let ((e227 (xor e220 e69)))
(let ((e228 (ite e221 e227 e221)))
(let ((e229 (not e116)))
(let ((e230 (xor e51 e197)))
(let ((e231 (not e228)))
(let ((e232 (and e222 e230)))
(let ((e233 (not e209)))
(let ((e234 (ite e177 e63 e180)))
(let ((e235 (and e217 e205)))
(let ((e236 (not e229)))
(let ((e237 (= e72 e181)))
(let ((e238 (xor e85 e225)))
(let ((e239 (=> e203 e193)))
(let ((e240 (= e223 e201)))
(let ((e241 (and e226 e231)))
(let ((e242 (= e155 e239)))
(let ((e243 (or e182 e216)))
(let ((e244 (=> e234 e219)))
(let ((e245 (xor e76 e61)))
(let ((e246 (= e240 e224)))
(let ((e247 (and e232 e238)))
(let ((e248 (ite e110 e247 e237)))
(let ((e249 (ite e211 e244 e89)))
(let ((e250 (=> e243 e249)))
(let ((e251 (ite e77 e235 e233)))
(let ((e252 (and e152 e206)))
(let ((e253 (and e248 e207)))
(let ((e254 (or e215 e246)))
(let ((e255 (or e253 e253)))
(let ((e256 (xor e242 e236)))
(let ((e257 (not e212)))
(let ((e258 (or e241 e241)))
(let ((e259 (ite e257 e251 e256)))
(let ((e260 (xor e259 e255)))
(let ((e261 (= e210 e250)))
(let ((e262 (and e258 e112)))
(let ((e263 (xor e262 e262)))
(let ((e264 (not e263)))
(let ((e265 (=> e264 e252)))
(let ((e266 (and e254 e261)))
(let ((e267 (xor e265 e245)))
(let ((e268 (=> e266 e260)))
(let ((e269 (and e267 e268)))
(let ((e270 (=> e269 e269)))
(let ((e271 (= e199 e199)))
(let ((e272 (and e271 e271)))
(let ((e273 (=> e272 e272)))
(let ((e274 (and e273 e273)))
(let ((e275 (and e274 e274)))
(let ((e276 (=> e275 e270)))
(let ((e277 (and e276 (not (= e18 (_ bv0 14))))))
(let ((e278 (and e277 (not (= v3 (_ bv0 4))))))
(let ((e279 (and e278 (not (= e32 (_ bv0 1))))))
e279
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
