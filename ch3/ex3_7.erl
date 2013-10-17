-module(ex3_7).

-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).
-export([test/0]).

% ex3_7:new() => Db.
% ex3_7:destroy(Db) => ok.
% ex3_7:write(Key, Element, Db) => NewDb.
% ex3_7:delete(Key, Db) => NewDb.
% ex3_7:read(Key, Db) => {ok, Element} | {error, instance}.
% ex3_7:match(Element, Db) => [Key1, ..., KeyN].

new() -> 
    [].

destroy(X) when is_list(X) -> 
    ok.

write(Key, Element, Db) -> 
    [{Key, Element}|lists:keydelete(Key, 1, Db)].

delete(Key, Db) -> 
    lists:keydelete(Key, 1, Db).

read(Key, Db) -> 
    read(lists:keyfind(Key, 1, Db)).
read(false) -> 
    {error, instance};
read({_, Element}) -> 
    {ok, Element}.

match(Element, Db) -> 
    [Key || {Key, X} <- Db, X =:= Element].

test() ->
    [] = Db = ex3_7:new(),
    [{francesco, london}] = Db1 = ex3_7:write(francesco, london, Db),
    [{lelle, stockholm}, {francesco, london}] = Db2 = ex3_7:write(lelle, stockholm, Db1),
    {ok, london} = ex3_7:read(francesco, Db2),
    [{joern, stockholm}, {lelle, stockholm}, {francesco, london}] = Db3 = ex3_7:write(joern, stockholm, Db2),
    {error, instance} = ex3_7:read(ola, Db3),
    [joern, lelle] = ex3_7:match(stockholm, Db3),
    [{joern, stockholm}, {francesco, london}] = Db4 = ex3_7:delete(lelle, Db3),
    [{francesco, prague}, {joern, stockholm}] = ex3_7:write(francesco, prague, Db4),
    [joern] = ex3_7:match(stockholm, Db4),
    ok.