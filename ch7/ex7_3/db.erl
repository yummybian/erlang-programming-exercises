-module(db).

-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).
-include("db.hrl").

new() -> 
    [].

destroy(Db) when is_list(Db) -> 
    ok.

write(Key, Element, Db) ->
    [#data{key=Key, data=Element}|delete(Key, Db)].

delete(_, []) ->
    [];
delete(Key, [#data{key=Key}|T]) ->
    T;
delete(Key, [H|T]) -> 
    [H|delete(Key, T)].

read(_, []) -> 
    {error, instance};
read(Key, [#data{key=Key, data=Element}|_]) -> 
    {ok, Element};
read(Key, [_|T]) -> 
    read(Key, T).

match(_, []) -> 
    [];
match(Element, [#data{key=Key, data=Element}|T]) -> 
    [Key|match(Element, T)];
match(Element, [_|T]) -> 
    match(Element, T).

