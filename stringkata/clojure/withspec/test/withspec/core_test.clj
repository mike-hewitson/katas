(ns withspec.core-test
  (:require [clojure.test :refer :all]
            [withspec.core :refer :all]))

(deftest return-zero-when-given-an-empty-string
  (testing "FIXME, I fail."
    (is (= 0 (stringkata "")))))
