-module(ex3_5).
-export([filter/2, reverse/1, concatenate/1, flatten/1, test/0]).

%% ex 3-5
filter(Lst, Element) -> filter(Lst, Element, []).
filter([], _, NewLst) -> lists:reverse(NewLst);
filter([H|T], Element, NewLst) -> 
    if
        H =< Element -> filter(T, Element, [H|NewLst]);
        true -> filter(T, Element, NewLst)
    end.

reverse(Lst) -> reverse(Lst, []).
reverse([], NewLst) -> NewLst;
reverse([H|T], NewLst) -> reverse(T, [H|NewLst]).

concatenate(Lst) -> concatenate(Lst, []).
concatenate([], NewLst) -> NewLst;
concatenate([H|T], NewLst) -> concatenate(T, NewLst++H).

flatten_helper(Lst) -> flatten_helper(Lst, []).
flatten_helper([], NewLst) -> NewLst;
flatten_helper([H|T], NewLst) ->
    if
        is_list(H) ->
            flatten_helper(T, flatten_helper(H) ++ NewLst);
        true ->
            flatten_helper(T, [H] ++ NewLst)
    end.
flatten(Lst) -> lists:reverse(flatten_helper(Lst)).

test() ->
    [1,2,3] = filter([1,2,3,4,5], 3),
    [3,2,1] = reverse([1,2,3]),
    [1,2,3,4,five] = concatenate([[1,2,3], [], [4, five]]),
    [1,2,3,4,5,6] = flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]),
    ok.