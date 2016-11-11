open Soup;;
open Markup;;
open Arg;;

let my_filter = ref "a";;
let my_attr = ref "data-ref";;

let speclist = [("-f", Arg.Set_string (my_filter), "le filtre");
("-attr", Arg.Set_string (my_attr),"attribute");];;
let usage_msg = "lambdasouper -f <filtre> -attr <attribute>" in
Arg.parse speclist print_endline usage_msg;
        print_endline ("filter : " ^ !my_filter);
print_endline ("attribute : " ^ !my_attr);;

let soup = Soup.read_channel stdin |> Soup.parse;;
soup $$ !my_filter |> Soup.to_list |> List.iter (fun a ->  a |> R.attribute !my_attr |> (^) "\n" |> print_string);;
