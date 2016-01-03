-module(day3b).
-export([main/1]).
-mode(compile).

value($>) -> {1,0};
value($<) -> {-1,0};
value($^) -> {0,1};
value($v) -> {0,-1};
value(_) -> {0,0}.

get_even(Input) ->
  {_, List} =lists:foldl(fun(Item, {Index, Evens}) -> case Index rem 2 of
                                            0 -> {Index + 1, Evens ++ [Item]};
                                            1 -> {Index + 1, Evens};
                                            _ -> {Index + 1, []}
                                          end end, {0, []}, Input),
  List.

get_odd(Input) ->
  {_, List} =lists:foldl(fun(Item, {Index, Odds}) -> case Index rem 2 of
                                                           1 -> {Index + 1, Odds ++ [Item]};
                                                           0 -> {Index + 1, Odds};
                                                           _ -> {Index + 1, []}
                                                         end end, {0, []}, Input),
  List.

load_file(In) ->
  {ok, File} = file:read_file(In),
  List = binary_to_list(File),
  lists:map(fun value/1, List).

moves(In) ->
  lists:foldl(fun({X, Y}, Set) -> {OldX, OldY} = lists:last(Set), Set ++ [{X + OldX, Y + OldY}] end, [{0, 0}], In).

compute_length(FieldsList) ->
  Set = ordsets:from_list(FieldsList),
  length(Set).

main(In) ->
  List = load_file(In),
  Odds = moves(get_odd(List)),
  Evens = moves(get_even(List)),
  Length = compute_length(Odds ++ Evens),
  io:write(Length),
  io:fwrite("\n").