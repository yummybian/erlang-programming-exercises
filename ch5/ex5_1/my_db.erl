-module(my_db).

-export([start/0, stop/0]).
-export([write/2, delete/1, read/1, match/1]).
-export([init/1]).

% my_db:start() => ok.
% my_db:stop() => ok.
% my_db:write(Key, Element) => ok.
% my_db:delete(Key) => ok.
% my_db:read(Key) => {ok, Element} | {error, instance}.
% my_db:match(Element) => [Key1, ..., KeyN].

start() -> 
    register(db, spawn(my_db, init, [[]])), 
    ok.

init([]) ->
    loop([]).

stop() ->
    db ! {stop, self()},
    receive {reply, Reply} -> Reply end.

write(Key, Element) ->
    call({write, Key, Element}).

delete(Key) ->
    call({delete, Key}).

read(Key) ->
    call({read, Key}).

match(Element) ->
    call({match, Element}).

call(Msg) -> 
    db ! {request, self(), Msg},
    receive {reply, Reply} -> Reply end.

handle_msg({write, Key, Element}, DbData) ->
    {ok, [{Key, Element}|lists:keydelete(Key, 1, DbData)]};

handle_msg({delete, Key}, DbData) ->
    {ok, lists:keydelete(Key, 1, DbData)};

handle_msg({read, Key}, DbData) ->
    case lists:keyfind(Key, 1, DbData) of
        false ->
            {{error, instance}, DbData};
        {_, Element} ->
            {{ok, Element}, DbData}
    end;

handle_msg({match, Element}, DbData) -> 
    {[Key || {Key, X} <- DbData, X =:= Element], DbData}.

reply(To, Msg) ->
    To ! {reply, Msg}.

loop(DbData) -> 
    receive 
        {request, From, Msg} -> 
            {Reply, NewDbData} = handle_msg(Msg, DbData),
            reply(From, Reply),
            loop(NewDbData);
        {stop, From} -> 
            reply(From, ok);
        _ ->
            {error, unknow_message}
    end.

