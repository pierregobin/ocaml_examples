open Nethttp_client;;
open Soup;;

let a = Convenience.http_get "http://www.champignonsen3clics.com/top-100-des-champignons-d-automne-partie-1-a-i/";; 
let a' = Soup.parse a;;
let w = a' $$ "a[data-href]" |> to_list |> List.map (fun a -> (a |> R.attribute "data-href", a |> R.attribute "data-title") );;
w |> List.map (fun (url,name) -> (name ^ "\n") |> print_string );;
