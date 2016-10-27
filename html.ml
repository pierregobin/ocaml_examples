module HTML : sig
        type (-'a) elt
        val pcdata : string -> [> `Pcdata of int] elt
        val span : [< `Span | `Pcdata of int] elt list
                   -> [> `Span ] elt
        val div : [< `Div | `Span | `Pcdata of int] elt list
                -> [> `Div] elt
end = struct
        type raw =
        | Node of string * raw list
        | Pcdata of string
        type 'a elt = raw
        let pcdata s = Pcdata s
        let div l = Node ("div", l)
        let span l = Node ("span", l)
end;;

