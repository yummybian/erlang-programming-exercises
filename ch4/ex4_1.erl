-module(ex4_1).
-export([start/0, print/1, stop/0, loop/0]).

start() -> 
    register(echo, spawn(ex4_1, loop, [])), 
    ok.

loop() -> 
    receive 
        {print, Term} -> 
            io:format("~p~n", [Term]),
            loop(); 
        stop -> 
            true;
        _ ->
            {error, unknow_message}
    end.

print(Term) ->
    echo ! {print, Term},
    ok.

stop() ->
    echo ! stop,
    ok.

  

