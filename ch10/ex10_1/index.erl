%% Code from 
%%   Erlang Programming
%%   Francecso Cesarini and Simon Thompson
%%   O'Reilly, 2008
%%   http://oreilly.com/catalog/9780596518189/
%%   http://www.erlangprogramming.org/
%%   (c) Francesco Cesarini and Simon Thompson

-module(index).

-export([processFile/2, prettyEntry/1]). 

-define(Punctuation,"(\\ |\\,|\\.|\\;|\\:|\\t|\\n|\\(|\\))+").

index(File) ->
  ets:new(indexTable, [ordered_set, named_table]),
  processFile(File),
  prettyIndex().

prettyEntryprocessFile(File) ->
  {ok,IoDevice} = file:open(File,[read]),
  processLines(IoDevice,1).

processLines(IoDevice,N) ->
  case io:get_line(IoDevice,"") of
    eof ->
      ok;
    Line ->
      processLine(Line,N),
      processLines(IoDevice,N+1)
  end.

processLine(Line,N) ->
  case re:split(Line,?Punctuation) of
    {ok,Words} ->
      processWords(Words,N) ;
    _ -> []
  end.

processWords(Words,N) ->
  case Words of
    [] -> ok;
    [Word|Rest] ->
      if
        length(Word) > 3 ->
          Normalise = string:to_lower(Word),
          ets:insert(indexTable,{{Normalise , N}});
        true -> ok
      end,
      processWords(Rest,N)
  end.

prettyIndex() ->
  case ets:first(indexTable) of
    '$end_of_table' ->
      ok;
    First  ->
      case First of
        {Word, N} ->
          IndexEntry = {Word, [N]}
      end,
      prettyIndexNext(First,IndexEntry)
  end.

prettyIndexNext(Entry,{Word, Lines}=IndexEntry) ->
  Next = ets:next(indexTable,Entry),
  case Next of
    '$end_of_table' ->
      prettyEntry(IndexEntry);
    {NextWord, M}  ->
      if
        NextWord == Word ->
          prettyIndexNext(Next,{Word, [M|Lines]});
        true ->
          prettyEntry(IndexEntry),
          prettyIndexNext(Next,{NextWord, [M]})
      end
  end.

% accumulate([7,6,6,5,3,3,1,1]) = [{1},{3},{5,7}]
accumulate(Ns) ->
    accumulate(Ns, []).

accumulate([], L) ->
    L;
accumulate([N|Ns], []) ->
    accumulate(Ns, [{N}]);
accumulate([N|Ns], [{X}|Rest]=Ms) ->
    if 
        X == N -> 
            accumulate(Ns, Ms);
        X == N+1 -> 
            accumulate(Ns, [{N, X}|Rest]);
        true -> 
            accumulate(Ns, [{N}|Ms])
    end;
accumulate([N|Ns], [{X, Y}|Rest]=Ms) -> 
    if 
        X == N -> 
            accumulate(Ns, Ms);
        X == N+1 -> 
            accumulate(Ns, [{N, Y}|Rest]); 
        true -> 
            accumulate(Ns, [{N}|Ms]) 
    end.

prettyList([]) -> 
    ok;
prettyList({[X]}) ->
    io:fwrite("~p.~n", [X]);
prettyList([{X, Y}]) ->
    io:fwrite("~p-~p.~n", [X, Y]);
prettyList([{X}|Xs]) ->
    io:fwrite("~p,", [X]),
    prettyList(Xs);
prettyList([{X, Y}|Rest]) ->
    io:fwrite("~p-~p,", [X, Y]),
    prettyList(Rest).

replicate(0, _) -> 
    [];
replicate(N, X) ->
    X ++ replicate(N-1, X).

pad(N, Word) ->
    Len = length(Word),
    if
        Len < N -> 
            Word ++ replicate(N-Len, " ");
        true -> 
            Word
    end.

prettyEntry({Word, Lines}) ->    
    io:put_chars(pad(20, Word)),
    prettyList(accumulate(Lines)).
