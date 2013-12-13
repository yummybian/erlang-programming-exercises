-module(my_db_sup).
-behavior(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
  UsrChild = {my_db, {my_db, start, []},
              permanent, 2000, worker, [my_db, my_db_sup]},
  {ok, {{one_for_all, 1, 3}, [UsrChild]}}.
