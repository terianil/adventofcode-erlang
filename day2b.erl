-module(day2b).
-export([main/1]).
-mode(compile).

compute_volume(X, Y, Z) -> X*Y*Z.

get_minimal_perimeter(X, Y, Z) -> lists:min([(2*X+2*Y), (2*Y+2*Z), (2*Z+2*X)]).

compute_total_lenght(X, Y, Z) -> compute_volume(X, Y, Z) + get_minimal_perimeter(X, Y, Z).

load_file(In) -> {ok, File} = file:read_file(In),
                  List = binary_to_list(File),
                  RawBoxes = string:tokens(List, "\r\n"),
                  RawBoxesDimensions = lists:map(fun(X) -> string:tokens(X, "x") end, RawBoxes),
                  Boxes = lists:map(fun(X) -> lists:map(fun(Y) -> list_to_integer(Y) end, X) end, RawBoxesDimensions),
                  lists:map(fun(X) -> list_to_tuple(X) end, Boxes).

main(In) -> Boxes = load_file(In),
            Lengths = lists:map(fun({X, Y, Z})-> compute_total_lenght(X, Y, Z) end, Boxes),
            Length = lists:sum(Lengths),
            io:write(Length),
            io:fwrite("\n").