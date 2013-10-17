-module(ex3_4).

-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).
-export([test/0]).

% ex3_4:new() => Db.
% ex3_4:destroy(Db) => ok.
% ex3_4:write(Key, Element, Db) => NewDb.
% ex3_4:delete(Key, Db) => NewDb.
% ex3_4:read(Key, Db) => {ok, Element} | {error, instance}.
% ex3_4:match(Element, Db) => [Key1, ..., KeyN].

new() -> 
    [].

destroy(X) when is_list(X) -> 
    ok.

write(Key, Element, Db) -> 
    [{Key, Element}|delete(Key, Db)].

delete(Key, [{Key, _}|Rest]) ->
    Rest;
delete(Key, [X| Rest]) -> 
    [X|delete(Key, Rest)];
delete(_, []) ->
    [].

read(_, []) -> 
    {error, instance};
read(Key, [{Key, Element}|_]) -> 
    {ok, Element};
read(Key, [{_, _}|Db]) -> 
    read(Key, Db).

match(Element, [{Key, Element}|Rest]) -> 
    [Key|match(Element, Rest)];
match(Element, [_|Rest]) -> 
    match(Element, Rest);
match(_, []) -> 
    [].

test() ->
    [] = Db = ex3_4:new(),
    [{francesco, london}] = Db1 = ex3_4:write(francesco, london, Db),
    [{lelle, stockholm}, {francesco, london}] = Db2 = ex3_4:write(lelle, stockholm, Db1),
    {ok, london} = ex3_4:read(francesco, Db2),
    [{joern, stockholm}, {lelle, stockholm}, {francesco, london}] = Db3 = ex3_4:write(joern, stockholm, Db2),
    {error, instance} = ex3_4:read(ola, Db3),
    [joern, lelle] = ex3_4:match(stockholm, Db3),
    [{joern, stockholm}, {francesco, london}] = Db4 = ex3_4:delete(lelle, Db3),
    [{francesco, prague}, {joern, stockholm}] = ex3_4:write(francesco, prague, Db4),
    [joern] = ex3_4:match(stockholm, Db4),
    ok.