-module(ex3_1).
-export([sum/1, sum/2, test/0]).

%% ex 3-1
sum(1) -> 1;
sum(N) -> N + sum(N-1).

sum(N, N) -> N;
sum(N, M) when N < M -> N + sum(N+1, M);
sum(_, _) -> erlang:error("Please input invalid range.").

test() ->
    15 = sum(5),
    6 = sum(1, 3),
    6 = sum(6, 6),
    ok.