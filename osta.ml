open Printf
open Str
open Omd

let create_page () = 
  (* TODO *)
  print_endline "create_page"


let read_whole_file filename =
    let ch = open_in filename in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s


let convert_to_html md_path = 
  (to_html (of_string (read_whole_file md_path)))


let get_html_path md_path output_path =
    output_path ^ Filename.dir_sep ^ (Str.replace_first (Str.regexp ".md") ".html" md_path)


let write_to_file(file, message) =
  let oc = open_out file in
  fprintf oc "%s\n" message;
  printf "Rendered to %s\n" file;
  close_out oc


let wrap_with_base_html base_path message = 
  Str.replace_first (Str.regexp "{content}") message (read_whole_file base_path)


let render output_path = 
  printf "Rendering HTML to %s\n" output_path;
  Sys.readdir "."
  |> Array.to_list
  |> List.filter (fun x -> Filename.extension x = ".md")
  |> List.iter (fun md_path -> write_to_file(
      (get_html_path md_path output_path), 
      (wrap_with_base_html "base.html" (convert_to_html md_path))) 
    );
  print_endline "Rendering complete"


let () =
  if Sys.argv.(1) = "create" then
    create_page()
  else if Sys.argv.(1) = "render" then
    render(if Array.length Sys.argv = 3 then Sys.argv.(2) else "..")
