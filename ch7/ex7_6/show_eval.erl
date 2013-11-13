-module(show_eval).
-export([test/0]).

-ifdef(show).
    -define(SHOW_EVAL(Exp), 
    (fun(Arg)->io:format("Exp=~p,Val=~p~n",[??Exp, Arg]),Arg end)(Exp)).
-else.
    -define(SHOW_EVAL(Exp),Exp).
-endif.

test() ->
    Result = ?SHOW_EVAL(io:format("Side Effect~n")),
    io:format("Result=~p~n",[Result]).