(*
Nice and clean and simple. Nuked the multiple delimiters. Ugly but effective.	
Did this to demo for other guys in the team	
*)

exception NoNegatives of int list

fun add s = 
	let
		val list_strings = String.tokens (fn c => not (Char.isDigit c orelse c = #"-"))
		val list_of_ints = List.map (fn x => case Int.fromString x of NONE => 0 | SOME n => n) (list_strings s)
		val list_neg_ints = List.filter (fn n => n < 0) list_of_ints
	in
		if list_neg_ints <> [] then raise NoNegatives list_neg_ints
		else List.foldl (fn (n,acc) => if n > 1000 then acc else n + acc) 0 list_of_ints
	end

val test1 = add("") = 0
val test2 = add("0") = 0
val test3 = add("1") = 1
val test4 = add("22") = 22
val test5 = add("0,2") = 2
val test6 = add("22,3") = 25
val test7 = add("1,2,3,4,5,6") = 21
val test8 = add("1,2,3\n4,5,6") = 21
val test9 = add("//:\n1:2:3:4:5:6") = 21
val test10 = (add("-1,2,-3,4,-5,6"); []) handle NoNegatives l => l
val test11= add("1000,2000,3000,1001,5,6") = 1011
val test12 = add("//[aaa]\n1aaa2aaa3") =  6
val test13 = add("//[aaa][bbb]\n1aaa2bbb3") =  6
