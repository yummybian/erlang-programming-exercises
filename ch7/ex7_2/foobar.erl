-module(foobar).
-export([foobar/1]).

-record(person, {name,age=0,phone,addr}).

foobar(P) when P#person.name == "Joe" -> joe;
foobar(_P) -> norecord.