-module(btree).
-export([sum/1, max/1, min/1, is_ordered/1, insert/2]).
-record(btree, {elem, left=[], right=[]}).

sum([]) -> 
    0;
sum(#btree{elem=E, left=L, right=R}) ->
    E + sum(L) + sum(R).

max([]) -> 
    [];
max(#btree{elem=E, left=L, right=R}) ->
    lists:max(lists:filter(fun erlang:is_number/1, [E, max(L), max(R)])).

min([]) ->
    [];
min(#btree{elem=E, left=L, right=R}) ->
    lists:min(lists:filter(fun erlang:is_number/1, [E, min(L), min(R)])).

is_ordered([]) ->
    true;
is_ordered(#btree{elem=E, left=L, right=R}) ->
    ((L == []) orelse (is_ordered(L) andalso max(L) =< E))
    andalso
    ((R == []) orelse (is_ordered(R) andalso min(L) >= E)).

insert([], NewElem) ->
    #btree{elem=NewElem};
insert(#btree{elem=E, left=L}=T, NewElem) when NewElem < E -> 
    T#btree{left=insert(L, NewElem)};
insert(#btree{right=R}=T, NewElem) ->
    T#btree{right=insert(R, NewElem)}.




