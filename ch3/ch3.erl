-module(ch3).
-export([sum/1, sum1/2, sum2/2, create/1, reverse_create/1, print_integers/2, print_even_integers/2, 
    new/0, destroy/1, write/3, delete/2, read/2, match/2]).

%% ex 3-1
sum(1) -> 1;
sum(N) -> N + sum(N-1).

sum1(N, M) ->
    if N < M -> N + sum1(N+1, M);
       N =:= M -> N;
       true -> erlang:error("Please input invalid range.")
    end.

sum2(N, N) -> N;
sum2(N, M) when N < M -> N + sum2(N+1, M);
sum2(_, _) -> erlang:error("Please input invalid range.").


%% ex 3-2
create(N) -> create(N, []).
create(0, Acc) -> Acc;
create(N, Acc) -> create(N-1, [N|Acc]).

reverse_create(N) -> reverse_create(1, N, []).
reverse_create(N, N, Acc) -> [N|Acc];
reverse_create(N, M, Acc) -> reverse_create(N+1, M, [N|Acc]).


%% ex 3-3
print_integers(N, N) -> 
    io:format("Number: ~p~n", [N]);
print_integers(N, M) when N < M-> 
    io:format("Number: ~p~n", [N]),
    print_integers(N+1, M);
print_integers(_, _) -> 
    erlang:error("Please input invalid range.").

print_even_integers(N, N) -> 
    case (N rem 2) == 0 of
        true -> io:format("Number: ~p~n", [N]);
        false -> io:format([])
    end;
print_even_integers(N, M) when N < M -> 
    case (N rem 2) == 0 of
        true -> io:format("Number: ~p~n", [N]);
        false -> io:format([])
    end,    
    print_even_integers(N+1, M);
print_even_integers(_, _) -> 
    erlang:error("Please input invalid range.").

%% ex 3-4
new() -> [].
destroy(_) -> ok.
write(Key, Element, Db) -> [{Key, Element}|Db].
delete(Key, Db) -> delete(Key, Db, []).
delete(_, [], NewDb) -> NewDb;
delete(Key, [{Key2, Element}|Db], NewDb) -> 
    if 
        Key == Key2 -> delete(Key, Db, NewDb);
        true -> delete(Key, Db, [{Key2, Element}|NewDb])
    end.
read(_, []) -> {error, instance};
read(Key, [{Key, Element}|_]) -> {ok, Element};
read(Key, [{_, _}|Db]) -> read(Key, Db).
match(Element, Db) -> match(Element, Db, []).
match(_, [], Keys) -> Keys;
match(Element, [{Key, Element}|Db], Keys) -> match(Element, Db, [Key|Keys]);
match(Element, [{_, _}|Db], Keys) -> match(Element, Db, Keys).


%% ex 3-5
filter(Lst, Element) -> filter(Lst, Element, []).
filter([], _, NewLst) -> NewLst;
filter([H|T], Element, NewLst) -> 
    if
        H <= Element -> filter(T, Element, [H|NewLst]);
        true -> filter(T, Element, NewLst)
    end.

reverse(Lst) -> reverse(Lst, []).
reverse([], NewLst) -> NewLst;
reverse([H|T], NewLst) -> reverse(T, [H|NewLst]).

concatenate_helper(Lst) -> concatenate_helper(Lst, []).
concatenate_helper([], NewLst) -> NewLst;
concatenate_helper([H|T], NewLst) -> concatenate_helper(T, H++NewLst).
concatenate(Lst) -> lists:reverse(concatenate_helper(Lst)).

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

%% ex 3-6
quick_sort([]) -> [];
quick_sort([Element]) -> [Element];
quick_sort([Pivot|Rest]) ->
    {Smaller, Larger} = Partition(Pivot, Rest, [], []),
    quick_sort(Smaller) ++ [Pivot] ++ quick_sort(Larger).

Partition(_, [], Smaller, Larger) -> {Smaller, Larger};
Partition(Pivot, [H|T], Smaller, Larger) -> 
    if 
        Pivot >= H -> Partition(Pivot, T, [H|Smaller], Larger),
        true -> Partition(Pivot, T, Smaller, [H|Larger])
    end.

merge_sort([]) -> [];
merge_sort([Element]) -> [Element];
merge_sort(Lst) -> 
    {Lst1, Lst2} = lists:split(length(Lst) rem 2, lst), 
    merge(merge_sort(Lst1), merge_sort(Lst2), []).

merge([], Lst2, SortedLst) -> SortedLst + Lst2;
merge(Lst1, [], SortedLst) -> SortedLst + Lst1;
merge([H1|T1], [H2|T2], SortedLst) -> 
    if 
        H1 <= H2 -> merge(T1, [H2|T2], [H1|SortedLst]);
        true -> merge([H1|T1], T2, [H2|SortedLst])
    end.


%% ex 3-7
