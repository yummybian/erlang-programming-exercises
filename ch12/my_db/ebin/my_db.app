{application, my_db, 
   [{description, "My Database"},
    {vsn, "1.0.0"},
    {modules, [my_db, my_db_gen, my_db_sup, my_db_app]},
    {registered, [my_db, my_db_sup]},
    {applications, [kernel, stdlib]},
    {env, []},
    {mod, {my_db_app,[]}}]}.
