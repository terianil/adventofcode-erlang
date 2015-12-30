-module(day2a).
-export([main/1]).
-mode(compile).

compute_area(X, Y, Z) -> 2*(X*Y) + 2*(Y*Z) + 2*(Z*X).

get_minimal_area(X, Y, Z) -> lists:min([(X*Y), (Y*Z), (Z*X)]).

compute_total_area(X, Y, Z) -> compute_area(X, Y, Z) + get_minimal_area(X, Y, Z).

load_file(In) -> {ok, File} = file:read_file(In),
                  List = binary_to_list(File),
                  RawBoxes = string:tokens(List, "\r\n"),
                  RawBoxesDimmensions = lists:map(fun(X) -> string:tokens(X, "x") end, RawBoxes),
                  Boxes = lists:map(fun(X) -> lists:map(fun(Y) -> list_to_integer(Y) end, X) end, RawBoxesDimmensions),
                  lists:map(fun(X) -> list_to_tuple(X) end, Boxes).

main(In) -> Boxes = load_file(In),
            Areas = lists:map(fun({X, Y, Z})-> compute_total_area(X, Y, Z) end, Boxes),
            TotalArea = lists:sum(Areas),
            io:write(TotalArea),
            io:fwrite("\n").