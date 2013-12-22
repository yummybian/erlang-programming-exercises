-module(muppet).
-export([create_schema/0, create_tables/0, write/3, read/1, increase_pay/2]).

-include("muppet.hrl").

create_schema() ->
    mnesia:create_schema([node()|nodes()]).
    
create_tables() ->
    mnesia:create_table(muppet, [{attributes, 
                        record_info(fields, muppet)}, 
                        {disc_copies, [node()|nodes()]}]).

write(Name, Callsign, Salary) ->
    mnesia:dirty_write(#muppet{name=Name, callsign=Callsign, salary=Salary}).

read(Name) ->
    mnesia:dirty_read({muppet, Name}).

increase_pay(Name, Rate) ->
    Trans = fun() -> 
        [M] = mnesia:read({muppet, Name}),
        Salary = M#muppet.salary*(1+Rate),
        New = M#muppet{salary=Salary},
        mnesia:write(New)
    end,
    mnesia:transaction(Trans).
