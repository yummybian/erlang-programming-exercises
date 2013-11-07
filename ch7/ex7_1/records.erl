-module(records).
-export([birthday/1, joe/0, showPerson/1]).

-record(person, {name,age=0,phone,addr}).

birthday(#person{age=Age} = P) ->
  P#person{age=Age+1}.

joe() ->
  #person{name="Joe",
          age=21,
          phone="999-999",
          addr="NJ"}.

showPerson(#person{age=Age,phone=Phone,name=Name,addr=Addr}) ->
  io:format("name: ~p  age: ~p  phone: ~p addr: ~p~n", [Name,Age,Phone,Addr]).