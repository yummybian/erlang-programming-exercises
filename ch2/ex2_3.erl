-module(ex2_3).
-export([b_not/1, b_and/2, b_or/2, b_nand/2, test/0]).

b_not(false) -> true;
b_not(_) -> false.

b_and(true, true) -> true;
b_and(_, _) -> false.

b_or(false, false) -> false;
b_or(_, _) -> true.

b_nand(X, Y) -> b_not(b_and(X, Y)).

test() ->
    true = ex2_3:b_not(false),
    false = ex2_3:b_and(false, true),
    true = ex2_3:b_and(ex2_3:b_not(ex2_3:b_and(true, false)), true),
    ok.