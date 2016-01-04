-module(day5a).
-export([main/1]).
-mode(compile).

check_not_contais_bad_strings(In) ->
  AB = string:str(In, "ab"),
  CD = string:str(In, "cd"),
  PQ = string:str(In, "pq"),
  XY = string:str(In, "xy"),
  (AB == 0) and (CD == 0) and (PQ == 0) and (XY == 0).

check_vowels(In) ->
  Vowels = lists:foldl(
    fun(Item, Acc) -> case Item of
                        $a -> Acc + 1;
                        $e -> Acc + 1;
                        $i -> Acc + 1;
                        $o -> Acc + 1;
                        $u -> Acc + 1;
                        _ -> {}, Acc
                      end
    end,
    0,
    In),
  Vowels >= 3.

check_all_conditions(In) ->
  Vowels = check_vowels(In),
  Exceptions = check_not_contais_bad_strings(In),
  Double_Letters = check_double_letters(In),
  (Vowels == true) and (Exceptions == true) and (Double_Letters == true).

check_double_letters(In) ->
  Letters = lists:seq($a, $z),
  Double_Letters = lists:foldl(fun(Item, Acc) -> case string:str(In, [Item, Item]) of 0 -> Acc; _ -> Acc + 1 end end, 0, Letters),
  Double_Letters > 0.

load_file(In) -> {ok, File} = file:read_file(In),
  List = binary_to_list(File),
  string:tokens(List, "\r\n").

main(In) ->
  Words = load_file(In),
  Correct = lists:foldl(fun(Item, Acc) -> case check_all_conditions(Item) of true -> Acc + 1; _ -> Acc end end, 0, Words),
  io:write(Correct),
  io:fwrite("\n").