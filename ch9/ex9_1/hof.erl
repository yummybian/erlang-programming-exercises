-module(hof).
-export([print_int/1, smaller/2, print_even/1, concat/1, sum/1]).

print_int(N) ->
    lists:map(fun(E)->io:format("~p~n", [E]) end, lists:seq(1, N)).

smaller(List, N) ->
    lists:map(fun(E)->E =< N end, List).

print_even(N) ->
    lists:map(fun(E)->io:format("~p~n",[E]) end, 
        lists:filter(fun(E)->E rem 2 == 0 end, lists:seq(1,N))).

concat(L) -> 
    lists:foldr(fun(E, Accu)->E ++ Accu end, [], L).

sum(L) ->
    lists:foldr(fun(E, Accu)->E + Accu end, 0, L).


