-module(day1b).
-export([main/1]).
-mode(compile).

value($() -> 1;
value($)) -> -1;
value(_) -> 0.

map_floors(Map) -> lists:map(fun value/1, Map).

filtermap(Fun, List1) ->
  lists:foldl(fun(Elem, {Index, Value}) ->
    case Fun(Value) of
      false -> {Index+1, Value+Elem};
      _ -> {Index, Value}
    end
              end, {0,0}, List1).

main(In) -> {ok, File} = file:read_file(In),
            Floors_Map = map_floors(binary_to_list(File)),
            AAA = filtermap(fun(Acc) -> case Acc of -1 -> true; _ -> false end end, Floors_Map),
            io:write(AAA),
            io:fwrite("\n").