
module Connection : sig
        type -'a t
        val connect_readonly : unit -> [`Readonly ] t
        val connect : unit -> [`Readonly | `Readwrite] t
        val status : [>`Readonly] t -> int
        val destroy : [>`Readwrite ] t -> unit
end = struct 
        type 'a t = int
        let count = ref 0
        let connect_readonly () = incr count; !count
        let connect () = incr count; !count
        let status c = c
        let destroy c = ()
end

open Connection;;
open Printf;;

let con = connect() in printf "status = %d\n" (status con); destroy con;;
let conn = connect_readonly() in printf "status = %d\n" (status conn);
destroy conn;;
