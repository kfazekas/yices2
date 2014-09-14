(set-logic QF_ABV)
(set-info :source |These benchmarks are derived from a semi-automated proof of functional equivalence between two implementations of an Elliptic Curve Digital Signature Algorithm (ECDSA). More information about problem they encode can be found here: http://cps-vo.org/node/3405|)
(set-info :smt-lib-version 2.0)
(set-info :category "industrial")
(set-info :status unsat)
(declare-fun x26 () (_ BitVec 1))
(declare-fun x25 () (_ BitVec 1))
(declare-fun x24 () (_ BitVec 384))
(declare-fun x23 () (_ BitVec 384))
(declare-fun x22 () (_ BitVec 384))
(declare-fun x21 () (_ BitVec 384))
(declare-fun x20 () (_ BitVec 384))
(declare-fun x19 () (_ BitVec 384))
(declare-fun x18 () (_ BitVec 1))
(declare-fun x17 () (_ BitVec 384))
(declare-fun x16 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x15 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x14 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x13 () (Array (_ BitVec 5) (_ BitVec 32)))
(declare-fun x12 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x11 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x10 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x9 () (Array (_ BitVec 5) (_ BitVec 32)))
(declare-fun x8 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x7 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x6 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x5 () (Array (_ BitVec 5) (_ BitVec 32)))
(declare-fun x4 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x3 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x2 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x1 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun x0 () (Array (_ BitVec 4) (_ BitVec 32)))
(declare-fun p27 () Bool)
(assert (= p27 (or (= x17 (_ bv0 384)) (= x23 x24))))
(assert (= x26 (bvor x18 x25)))
(assert (= x25 (ite (= x23 x24) (_ bv1 1) (_ bv0 1))))
(assert (= x24 (concat (concat (concat (concat (concat (concat (concat (concat (concat (concat (concat (select x0 (_ bv11 4)) (select x0 (_ bv10 4))) (select x0 (_ bv9 4))) (select x0 (_ bv8 4))) (select x0 (_ bv7 4))) (select x0 (_ bv6 4))) (select x0 (_ bv5 4))) (select x0 (_ bv4 4))) (select x0 (_ bv3 4))) (select x0 (_ bv2 4))) (select x0 (_ bv1 4))) (select x0 (_ bv0 4)))))
(assert (= x23 (bvsub x19 x22)))
(assert (= x22 (bvsub x20 x21)))
(assert (= x21 (concat (concat (concat (concat (concat (concat (concat (concat (concat (concat (concat (select x0 (_ bv11 4)) (select x0 (_ bv10 4))) (select x0 (_ bv9 4))) (select x0 (_ bv8 4))) (select x0 (_ bv7 4))) (select x0 (_ bv6 4))) (select x0 (_ bv5 4))) (select x0 (_ bv4 4))) (select x0 (_ bv3 4))) (select x0 (_ bv2 4))) (select x0 (_ bv1 4))) (select x0 (_ bv0 4)))))
(assert (= x20 (bvneg (_ bv340282367000166625977638945021017194497 384))))
(assert (= x19 (bvneg (_ bv340282367000166625977638945021017194497 384))))
(assert (= x18 (ite (= x17 (_ bv0 384)) (_ bv1 1) (_ bv0 1))))
(assert (= x17 (concat (concat (concat (concat (concat (concat (concat (concat (concat (concat (concat (select x0 (_ bv11 4)) (select x0 (_ bv10 4))) (select x0 (_ bv9 4))) (select x0 (_ bv8 4))) (select x0 (_ bv7 4))) (select x0 (_ bv6 4))) (select x0 (_ bv5 4))) (select x0 (_ bv4 4))) (select x0 (_ bv3 4))) (select x0 (_ bv2 4))) (select x0 (_ bv1 4))) (select x0 (_ bv0 4)))))
(assert true)
(assert (= (select x16 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x16 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x16 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x16 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x15 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x15 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x15 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x15 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x14 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x14 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x14 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x14 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x13 (_ bv31 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv30 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv29 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv28 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv27 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv26 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv25 5)) (_ bv0 32)))
(assert (= (select x13 (_ bv24 5)) (_ bv0 32)))
(assert (= (select x12 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x12 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x12 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x12 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x11 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x11 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x11 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x11 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x10 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x10 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x10 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x10 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x9 (_ bv31 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv30 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv29 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv28 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv27 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv26 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv25 5)) (_ bv0 32)))
(assert (= (select x9 (_ bv24 5)) (_ bv0 32)))
(assert (= (select x8 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x8 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x8 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x8 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x7 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x7 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x7 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x7 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x6 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x6 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x6 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x6 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x5 (_ bv31 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv30 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv29 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv28 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv27 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv26 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv25 5)) (_ bv0 32)))
(assert (= (select x5 (_ bv24 5)) (_ bv0 32)))
(assert (= (select x4 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x4 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x4 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x4 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x3 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x3 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x3 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x3 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x2 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x2 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x2 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x2 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x1 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x1 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x1 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x1 (_ bv12 4)) (_ bv0 32)))
(assert (= (select x0 (_ bv15 4)) (_ bv0 32)))
(assert (= (select x0 (_ bv14 4)) (_ bv0 32)))
(assert (= (select x0 (_ bv13 4)) (_ bv0 32)))
(assert (= (select x0 (_ bv12 4)) (_ bv0 32)))
(assert (not (=> true p27)))
(check-sat)
(exit)
