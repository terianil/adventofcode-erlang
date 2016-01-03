-module(day3a).
-export([main/1]).
-mode(compile).

value($>) -> {1,0};
value($<) -> {-1,0};
value($^) -> {0,1};
value($v) -> {0,-1};
value(_) -> {0,0}.

load_file(In) -> {ok, File} = file:read_file(In),
                  List = binary_to_list(File),
                  Movements = lists:map(fun value/1, List),
                  FieldsList = lists:foldl(fun({X, Y}, Set) -> {OldX, OldY} = lists:last(Set), Set ++ [{X + OldX, Y + OldY}] end, [{0, 0}], Movements),
                  Set = ordsets:from_list(FieldsList),
                  length(Set).

main(In) -> Length = load_file(In),
            io:write(Length),
            io:fwrite("\n").