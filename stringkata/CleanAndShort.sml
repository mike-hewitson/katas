(*
Nice and clean and simple. Only up to the multi character delimiters, as they 
require regex or building all of the string search componnets manually.	
*)

exception NoNegatives of int list

fun add s = 
	let
		val delimiter = if String.isPrefix "//" s then String.sub(s ,2) else #","
		val split_string_up = String.tokens (fn c => c = delimiter orelse c = #"\n")
		val list_of_ints = List.map (fn x => case Int.fromString x of NONE => 0 | SOME n => n) (split_string_up s)
		val list_of_negatives = List.filter (fn n => n < 0) list_of_ints
	in
		if list_of_negatives <> [] then raise NoNegatives list_of_negatives
		else List.foldl (fn (x,acc) => if x > 1000 then acc else x + acc) 0 list_of_ints
	end

val test1 = add("") = 0
val test2 = add("0") = 0
val test3 = add("1") = 1
val test4 = add("22") = 22
val test5 = add("1,2") = 3
val test6 = add("2,22") = 24
val test7 = add("1,2,3,4,5,6") = 21
val test8 = add("1,2,3\n4,5,6") = 21
val test9 = add("//:\n1:2:3:4:5:6") = 21
val test10 = (add("//:\n-1:2:-3:4:-5:6"); []) handle NoNegatives l => l
val test11 = add("1000,2000,1001,4,5,6") = 1015