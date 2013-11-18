-module(lc).
-export([div3/0, int_seq/1, intersection/2, symdiff/2]).

div3() ->
    [X || X <- lists:seq(1, 10), X rem 3 == 0].

int_seq(L) ->
    [X*X || X <- L, is_integer(X)].

intersection(L1, L2) ->
    [X || X <- L1, Y <- L2, X == Y].

symdiff(L1, L2) ->
    [X || X <- L1, not lists:member(X, L2)] ++ 
    [X || X <- L2, not lists:member(X, L1)].