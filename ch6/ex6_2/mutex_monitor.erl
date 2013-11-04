%% Code from 
%%   Erlang Programming
%%   Francecso Cesarini and Simon Thompson
%%   O'Reilly, 2008
%%   http://oreilly.com/catalog/9780596518189/
%%   http://www.erlangprogramming.org/
%%   (c) Francesco Cesarini and Simon Thompson

-module(mutex_monitor).
-export([start/0, stop/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() -> 
    register(mutex, spawn(?MODULE, init, [])).

stop() -> 
    mutex ! stop.

wait() ->
    mutex ! {wait, self()},
    receive ok -> ok end.

signal() ->
    mutex ! {signal, self()}, ok.

init() ->
    free().

free() ->
    receive
        {wait, Pid} -> 
            Ref = erlang:monitor(process, Pid),
            Pid ! ok, 
            busy(Pid, Ref);
        stop -> 
            terminate() 
    end.

busy(Pid, Ref) -> 
    receive 
        {signal, Pid} -> 
            erlang:demonitor(Ref, [flush]),
            free();
        {'DOWN', Ref, process, Pid, _Reason} ->
            erlang:demonitor(Ref, [flush]),
            free()
    end.

terminate() -> 
    receive 
        {wait, Pid} -> 
            exit(Pid, kill), 
            terminate() 
        after
            0 -> ok 
    end.

