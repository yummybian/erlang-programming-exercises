-module(ex3_3).
-export([print_integers/2, print_even_integers/2]).

%% ex 3-3
print_integers(N, N) -> 
    io:format("Number: ~p~n", [N]);
print_integers(N, M) when N < M-> 
    io:format("Number: ~p~n", [N]),
    print_integers(N+1, M);
print_integers(_, _) -> 
    erlang:error("Please input invalid range.").

print_even_integers(N, N) -> 
    case (N rem 2) == 0 of
        true -> io:format("Number: ~p~n", [N]);
        false -> io:format([])
    end;
print_even_integers(N, M) when N < M -> 
    case (N rem 2) == 0 of
        true -> io:format("Number: ~p~n", [N]);
        false -> io:format([])
    end,    
    print_even_integers(N+1, M);
print_even_integers(_, _) -> 
    erlang:error("Please input invalid range.").


