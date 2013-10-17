-module(ex4_2).
-export([start/3, start_proc/4]).

start(M, N, Message) ->
    start_proc(self(), M, N, Message),
    ok.

start_proc(Pid, M, 0, Message) ->
    send_messages(Pid, M, Message),
    recv_messages(M, Message),
    Pid ! {Pid, ok};
start_proc(Pid, M, N, Message) ->
    NPid = spawn(?MODULE, start_proc, [Pid, M, N-1, Message]),
    send_messages(NPid, M, Message),
    recv_messages(M, Message),
    receive {_Pid, ok} -> ring_end end.

send_messages(_, 0, _) ->
    send_msg_end;
send_messages(Pid, M, Message) ->
    Pid ! {self(), Pid, Message},
    io:format("pid:~p send message:~p to pid:~p~n", [self(), Message, Pid]),
    send_messages(Pid, M-1, Message).

recv_messages(0, _) ->
    recv_msg_end;
recv_messages(M, Message) ->
    receive
        {From, _Pid, Message} when M > 0 ->
            io:format("pid:~p receive message:~p from pid:~p~n", [_Pid, Message, From]),
            recv_messages(M-1, Message)
    end.

