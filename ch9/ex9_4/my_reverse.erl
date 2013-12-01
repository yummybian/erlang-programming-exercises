-module(my_reverse).
-export([reverse/1]).

reverse(L) ->
    reverse(L, []).

reverse([], Acc) ->
    Acc;
reverse([H|T], Acc) ->
    reverse(T, [H|Acc]).