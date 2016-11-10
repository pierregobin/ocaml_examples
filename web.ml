open Nethttp_client;;
open Soup;;

let a = Convenience.http_get Sys.argv.(1);;
let a' = Soup.parse a;;
let w = a' $$ "a[data-href]" |> to_list |> List.map (fun a -> (a |> R.attribute "data-href", a |> R.attribute "data-title") );;
w |> List.map (fun (url,name) -> 
                let jpg =  Str.split (Str.regexp "/") url 
                           |> Array.of_list 
                           |> fun x -> Array.get x ((Array.length x) - 2) 
                in
                begin
                        (* Printf.printf "%s -> %s.jpg\n" name jpg; *)
                        let latin = List.hd (Str.split (Str.regexp " -") name) in
                        let latin = Str.global_replace (Str.regexp " ") "_" latin in
                        let c = "wget " ^ url ^ " -O " ^ latin ^ ".jpg" in
                        begin
                        Printf.printf "download [%s]\n" name ;
                        Sys.command(c);
                        end
                end
);;
