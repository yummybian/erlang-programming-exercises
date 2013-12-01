%% Code from 
%%   Erlang Programming
%%   Francecso Cesarini and Simon Thompson
%%   O'Reilly, 2008
%%   http://oreilly.com/catalog/9780596518189/
%%   http://www.erlangprogramming.org/
%%   (c) Francesco Cesarini and Simon Thompson

-module(index2).

-export([processWords/2]).

processWords(Words, N) ->
  case Words of
    [] -> ok;
    [Word|Rest] ->
      if
        length(Word) > 3 ->
          Normalise = string:to_lower(Word),
          case ets:lookup(indexTable, Normalise) of 
            [] -> 
              ets:insert(indexTable, {Normalise, [N]});
            [{_, Ns}] ->
                lists:insert(indexTable, {Normalise, [N|Ns]})
          end;
        true -> ok
      end,
      processWords(Rest, N)
  end.



