
module Quotient(R : sig 
type t
val a : t -> t ->t
val  b  : t -> t -> t
val c : t -> t -> t
val d : t -> t -> t
end
)
 = struct
        type t = R.t * R.t

        let create (x1,x2) = (x1,x2)
        let  a  (x1,x2) (y1, y2) = (R.a x1 x2, R.a y1 y2)
        let  b  (x1,x2) (y1, y2) = (R.b x1 x2, R.b y1 y2)
        let  c  (x1,x2) (y1, y2) = (R.c x1 x2, R.c y1 y2)
        let  d  (x1,x2) (y1, y2) = (R.d x1 x2, R.d y1 y2)

end;;

module Quotient2(R : sig 
type t
val (+) : t -> t ->t
val (-)  : t -> t -> t
val ( * ) : t -> t -> t
val (/) : t -> t -> t
val gcd : t -> t -> t
val positive : t -> bool
val zero : t
val to_s : t -> string
end
) : sig 
        type t
        val create : (R.t * R.t) -> t
        val (+) : t -> t -> t
        val (-) : t -> t -> t
        val ( * ) : t -> t -> t
        val (/) : t -> t -> t
        val to_s : t -> string * string
        val pp_print : Format.formatter -> t -> unit
end = struct
        type t = R.t * R.t

        let create (x1,x2) = 
                if x2 = R.zero then 
                                failwith "Error - denominator is null"
                else (x1,x2)
        let simplify (n,d) = 
                let (n,d) = if R.positive d then (n,d) 
                        else (R.(-) R.zero n, R.(-) R.zero d) in
                let g = R.gcd n d in
                (R.(/) n g, R.(/) d g)
        let  (+)  (x1,x2) (y1, y2) =
                let num = (R.(+) (R.( * ) x1 y2) (R.( * ) x2 y1)) in
                let den =  R.( * ) y1 y2 in
                simplify (num,den)
                
        let  (-)  (x1,x2) (y1, y2) = simplify ( (+) (x1,x2)  (R.(-) R.zero y1,y2))
        let  ( * )  (x1,x2) (y1, y2) = simplify (R.( * ) x1 x2, R.( * ) y1 y2)
        let  (/)  (x1,x2) (y1, y2) =simplify( ( * ) (x1,x2) (y2,y1))
        let to_s (x,y) =  (R.to_s x , R.to_s y) 
        let pp_print f x = Format.pp_print_string f ((R.to_s (fst x) ) ^ "/" ^ (R.to_s (snd x)))

end;;


module Int = struct 
        type t = int
        let (+) = (+)
        let (-) = (-)
        let ( * ) = ( * )
        let (/) = (/)
        let zero = 0
        let positive = function x -> x > 0
        let rec gcd a b = 
                if b = 0 then a
                else gcd b (a mod b)
        let to_s = string_of_int
end;;


module M = Quotient2(Int);;
let a = M.create (4,5);;
let b = M.create (8,5);;

#load "nums.cma";;
module Bigint = struct
        type t = Big_int.big_int
        let (+) = Big_int.add_big_int
        let (-) = Big_int.sub_big_int
        let (/) = Big_int.div_big_int
        let ( * ) = Big_int.mult_big_int
        let gcd = Big_int.gcd_big_int
        let zero = Big_int.zero_big_int
        let positive = function x -> Big_int.gt_big_int x zero
        let to_s = Big_int.string_of_big_int 
end;;

module N = Quotient2(Bigint);;
#install_printer N.pp_print;;
