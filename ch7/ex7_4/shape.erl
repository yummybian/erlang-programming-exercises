-module(shape).

-record(circle, {radius}).
-record(rectangle, {length, width}).
-record(triangle, {a, b, c}).

-export([perimeter/1, area/1]).

perimeter(#circle{radius=Rad}) ->
    2 * math:pi() * Rad;
perimeter(#rectangle{length=Len, width=Wid}) ->
    2 * (Len + Wid);
perimeter(#triangle{a=A, b=B, c=C}) ->
    A + B + C.

area(#circle{radius=Rad}) ->
    Rad * Rad * math:pi();
area(#rectangle{length=Len,width=Wid}) ->
    Len * Wid;
area(#triangle{a=A,b=B,c=C}) ->
    S = (A+B+C) / 2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).