(set-info :source |fuzzsmt|)
(set-info :smt-lib-version 2.0)
(set-info :category "random")
(set-info :status unknown)
(set-logic QF_LRA)
(declare-fun v0 () Real)
(assert (let ((e1 6))
(let ((e2 0))
(let ((e3 0))
(let ((e4 (- v0 v0)))
(let ((e5 (- e4)))
(let ((e6 (/ e2 (- e1))))
(let ((e7 (- e5)))
(let ((e8 (- e7 e4)))
(let ((e9 (/ e2 e1)))
(let ((e10 (- e9)))
(let ((e11 (+ e6 e5)))
(let ((e12 (- e5 v0)))
(let ((e13 (- e7)))
(let ((e14 (/ e3 (- e1))))
(let ((e15 (> e11 e7)))
(let ((e16 (>= e6 e11)))
(let ((e17 (= v0 e6)))
(let ((e18 (= e13 e8)))
(let ((e19 (< e11 e13)))
(let ((e20 (< e12 e14)))
(let ((e21 (distinct e11 e10)))
(let ((e22 (= e11 e11)))
(let ((e23 (<= e13 e12)))
(let ((e24 (> e5 e8)))
(let ((e25 (<= e13 e6)))
(let ((e26 (>= e7 e12)))
(let ((e27 (= e14 e9)))
(let ((e28 (<= e8 e4)))
(let ((e29 (ite e24 e10 e4)))
(let ((e30 (ite e23 v0 e4)))
(let ((e31 (ite e26 e13 e30)))
(let ((e32 (ite e17 e7 e6)))
(let ((e33 (ite e16 e5 e4)))
(let ((e34 (ite e16 e8 e10)))
(let ((e35 (ite e15 e13 e9)))
(let ((e36 (ite e22 e14 e35)))
(let ((e37 (ite e28 e11 v0)))
(let ((e38 (ite e19 e12 e6)))
(let ((e39 (ite e27 e4 e35)))
(let ((e40 (ite e26 e13 e38)))
(let ((e41 (ite e15 e38 e29)))
(let ((e42 (ite e19 v0 e30)))
(let ((e43 (ite e20 e10 e29)))
(let ((e44 (ite e27 e37 e8)))
(let ((e45 (ite e25 e32 e33)))
(let ((e46 (ite e15 e44 e5)))
(let ((e47 (ite e17 e43 e7)))
(let ((e48 (ite e21 e33 v0)))
(let ((e49 (ite e18 e33 e45)))
(let ((e50 (distinct e45 e6)))
(let ((e51 (> e14 e47)))
(let ((e52 (< e7 e13)))
(let ((e53 (>= e12 e29)))
(let ((e54 (> e35 e7)))
(let ((e55 (< e40 e4)))
(let ((e56 (> e39 e39)))
(let ((e57 (distinct e46 e49)))
(let ((e58 (< e6 e11)))
(let ((e59 (= e4 e33)))
(let ((e60 (distinct e31 e41)))
(let ((e61 (> e43 e47)))
(let ((e62 (> e32 e11)))
(let ((e63 (= e35 e44)))
(let ((e64 (<= e48 e36)))
(let ((e65 (distinct e37 e6)))
(let ((e66 (>= e4 e39)))
(let ((e67 (= e41 e41)))
(let ((e68 (> e10 e31)))
(let ((e69 (<= e33 e14)))
(let ((e70 (>= e38 e6)))
(let ((e71 (>= e34 e48)))
(let ((e72 (<= e6 e44)))
(let ((e73 (<= e11 e8)))
(let ((e74 (distinct e40 e31)))
(let ((e75 (distinct e37 e13)))
(let ((e76 (>= e38 e10)))
(let ((e77 (> e13 e44)))
(let ((e78 (>= e47 e35)))
(let ((e79 (> e38 e49)))
(let ((e80 (> e42 e5)))
(let ((e81 (= e42 v0)))
(let ((e82 (>= e6 e29)))
(let ((e83 (<= e5 e46)))
(let ((e84 (distinct e8 e32)))
(let ((e85 (>= e9 e31)))
(let ((e86 (>= e11 e38)))
(let ((e87 (>= e47 e36)))
(let ((e88 (> e31 e10)))
(let ((e89 (<= e40 e31)))
(let ((e90 (<= e4 e4)))
(let ((e91 (>= e42 e31)))
(let ((e92 (> e36 e13)))
(let ((e93 (< e44 e29)))
(let ((e94 (>= e6 e43)))
(let ((e95 (>= e34 v0)))
(let ((e96 (>= e46 e33)))
(let ((e97 (< e40 e49)))
(let ((e98 (= e9 e47)))
(let ((e99 (> e10 e43)))
(let ((e100 (>= e37 e6)))
(let ((e101 (distinct e13 e46)))
(let ((e102 (> e29 e29)))
(let ((e103 (= e13 e35)))
(let ((e104 (= e5 e5)))
(let ((e105 (> e45 e6)))
(let ((e106 (> e10 e4)))
(let ((e107 (>= e7 e47)))
(let ((e108 (< v0 e32)))
(let ((e109 (< e13 e11)))
(let ((e110 (< e11 e32)))
(let ((e111 (= e39 e31)))
(let ((e112 (< e34 e5)))
(let ((e113 (= e10 e10)))
(let ((e114 (distinct e48 e13)))
(let ((e115 (< e12 e14)))
(let ((e116 (<= e8 e33)))
(let ((e117 (= e43 e10)))
(let ((e118 (= e12 e8)))
(let ((e119 (distinct v0 e37)))
(let ((e120 (< e36 e5)))
(let ((e121 (= e8 e9)))
(let ((e122 (= e36 e46)))
(let ((e123 (< e30 e14)))
(let ((e124 (=> e78 e120)))
(let ((e125 (or e95 e112)))
(let ((e126 (=> e94 e76)))
(let ((e127 (or e81 e81)))
(let ((e128 (not e74)))
(let ((e129 (xor e115 e126)))
(let ((e130 (ite e61 e113 e88)))
(let ((e131 (or e100 e53)))
(let ((e132 (= e96 e20)))
(let ((e133 (xor e26 e79)))
(let ((e134 (not e77)))
(let ((e135 (not e98)))
(let ((e136 (and e66 e132)))
(let ((e137 (= e128 e108)))
(let ((e138 (and e54 e72)))
(let ((e139 (ite e104 e60 e130)))
(let ((e140 (ite e83 e75 e119)))
(let ((e141 (ite e63 e138 e91)))
(let ((e142 (not e103)))
(let ((e143 (xor e85 e114)))
(let ((e144 (not e28)))
(let ((e145 (ite e15 e25 e93)))
(let ((e146 (and e117 e134)))
(let ((e147 (=> e118 e19)))
(let ((e148 (or e145 e52)))
(let ((e149 (=> e124 e121)))
(let ((e150 (xor e64 e149)))
(let ((e151 (ite e23 e67 e101)))
(let ((e152 (not e141)))
(let ((e153 (xor e111 e56)))
(let ((e154 (and e86 e90)))
(let ((e155 (xor e129 e147)))
(let ((e156 (not e97)))
(let ((e157 (ite e73 e137 e69)))
(let ((e158 (and e139 e140)))
(let ((e159 (xor e62 e21)))
(let ((e160 (=> e80 e143)))
(let ((e161 (=> e51 e27)))
(let ((e162 (xor e155 e116)))
(let ((e163 (= e17 e131)))
(let ((e164 (xor e22 e162)))
(let ((e165 (or e158 e133)))
(let ((e166 (ite e152 e57 e122)))
(let ((e167 (= e55 e109)))
(let ((e168 (and e164 e71)))
(let ((e169 (=> e127 e159)))
(let ((e170 (ite e123 e166 e154)))
(let ((e171 (not e167)))
(let ((e172 (ite e160 e106 e144)))
(let ((e173 (or e156 e58)))
(let ((e174 (=> e146 e89)))
(let ((e175 (and e125 e161)))
(let ((e176 (not e84)))
(let ((e177 (=> e157 e170)))
(let ((e178 (ite e173 e110 e150)))
(let ((e179 (xor e82 e169)))
(let ((e180 (or e16 e168)))
(let ((e181 (or e175 e177)))
(let ((e182 (= e70 e99)))
(let ((e183 (not e87)))
(let ((e184 (or e179 e59)))
(let ((e185 (and e24 e184)))
(let ((e186 (or e185 e142)))
(let ((e187 (or e182 e18)))
(let ((e188 (not e186)))
(let ((e189 (and e176 e136)))
(let ((e190 (ite e65 e172 e181)))
(let ((e191 (xor e148 e165)))
(let ((e192 (ite e151 e190 e92)))
(let ((e193 (=> e102 e188)))
(let ((e194 (ite e180 e153 e180)))
(let ((e195 (or e135 e187)))
(let ((e196 (=> e189 e107)))
(let ((e197 (and e50 e178)))
(let ((e198 (or e105 e191)))
(let ((e199 (ite e195 e198 e196)))
(let ((e200 (xor e183 e68)))
(let ((e201 (ite e171 e192 e200)))
(let ((e202 (=> e197 e174)))
(let ((e203 (and e194 e202)))
(let ((e204 (ite e163 e163 e193)))
(let ((e205 (not e201)))
(let ((e206 (xor e205 e204)))
(let ((e207 (and e206 e206)))
(let ((e208 (=> e199 e203)))
(let ((e209 (not e207)))
(let ((e210 (=> e208 e208)))
(let ((e211 (and e210 e210)))
(let ((e212 (not e211)))
(let ((e213 (not e212)))
(let ((e214 (and e213 e209)))
e214
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
