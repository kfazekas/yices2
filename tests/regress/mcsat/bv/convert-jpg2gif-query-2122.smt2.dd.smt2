(set-logic QF_BV)
(declare-fun x0 () (_ BitVec 32))
(declare-fun x1 () (_ BitVec 32))
(declare-fun x2 () (_ BitVec 32))
(declare-fun x3 () (_ BitVec 32))
(declare-fun x4 () (_ BitVec 32))
(declare-fun x5 () (_ BitVec 32))
(declare-fun x6 () (_ BitVec 32))
(declare-fun x7 () (_ BitVec 32))
(declare-fun x8 () (_ BitVec 32))
(declare-fun x9 () (_ BitVec 32))
(assert (= (_ bv0 32) x1))
(assert (= x5 x7))
(assert (= x3 x0))
(assert (= x2 x0))
(assert (= ((_ extract 31 0) x8) (bvmul x2 (_ bv8 32))))
(assert (= x9 x8))
(assert (= x6 (bvadd x9 (_ bv8 32))))
(assert (= x4 (bvsub x6 (_ bv1 32))))
(check-sat)
(exit)