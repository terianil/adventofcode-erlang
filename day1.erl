-module(day1).
-export([main/1]).
-mode(compile).

value($() -> 1;
value($)) -> -1;
value(_) -> 0.

sum_floors(Map) -> lists:sum(lists:map(fun value/1, Map)).

main(In) -> {ok, File} = file:read_file(In),
            Sum = sum_floors(binary_to_list(File)),
            io:write(Sum),
            io:fwrite("\n").