(ns withspec.core
  (:require [clojure.spec :as s]))

(defn stringkata
  "return "
  [x]
  0)

(s/def ::string string?)
(s/valid? ::string "")

(stringkata "")
