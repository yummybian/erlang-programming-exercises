-module(my_db_gen).
-export([write/2, read/2, match/2, delete/2]).

write({Key, Element}, DbData) ->
    {ok, [{Key, Element}|lists:keydelete(Key, 1, DbData)]}.

read(Key, DbData) ->
    case lists:keyfind(Key, 1, DbData) of
        false ->
            {{error, instance}, DbData};
        {_, Element} ->
            {{ok, Element}, DbData}
    end.

match(Element, DbData) -> 
    Reply = [Key || {Key, X} <- DbData, X =:= Element], 
    {Reply, DbData}.

delete(Key, DbData) ->
    {ok, lists:keydelete(Key, 1, DbData)}.

