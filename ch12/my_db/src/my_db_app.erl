-module(my_db_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _StartArgs) ->
    my_db_sup:start_link().
    
stop(_State) ->
    ok.