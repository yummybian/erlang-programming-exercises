-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

start() -> 
    register(echo, spawn(echo, loop, [])), 
    ok.

loop() -> 
    receive 
        {print, Term, Pid} -> 
            link(Pid),
            io:format("~p~n", [Term]),
            loop(); 
        stop -> 
            true;
        _ ->
            {error, unknow_message}
    end.

print(Term) ->
    echo ! {print, Term, self()},
    ok.

stop() ->
    % echo ! stop,
    exit(self(), kill),
    ok.

  

