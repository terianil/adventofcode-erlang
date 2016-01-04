-module(day4b).
-export([main/1]).
-mode(compile).


md5_hex(S) ->
  Md5_bin =  erlang:md5(S),
  Md5_list = binary_to_list(Md5_bin),
  lists:flatten(list_to_hex(Md5_list)).

list_to_hex(L) ->
  lists:map(fun(X) -> int_to_hex(X) end, L).

int_to_hex(N) when N < 256 ->
  [hex(N div 16), hex(N rem 16)].

hex(N) when N < 10 ->
  $0+N;
hex(N) when N >= 10, N < 16 ->
  $a + (N-10).

check_md5(Md5) ->
  case string:str(Md5, [48,48,48,48,48,48]) of
    1 -> 1;
    _ -> 0
  end.

generate_md5(Text) ->
  Numbers = lists:seq(1, 100000000),
  lists:map(fun(X) -> case check_md5(md5_hex(Text ++ integer_to_list(X))) of
                          1 -> io:write(X), io:fwrite("\n");
                          _ -> 0
                      end end, Numbers).

main(In) ->
  generate_md5(In),
  io:fwrite("\n").