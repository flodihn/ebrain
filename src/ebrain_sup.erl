-module(ebrain_sup).
 
-behaviour(supervisor).
 
%% API
-export([start_link/0]).
 
%% Supervisor callbacks
-export([init/1]).
 
%% ===================================================================
%% API functions
%% ===================================================================
 
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).
 
%% ===================================================================
%% Supervisor callbacks
%% ===================================================================
 
init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 10,
    MaxSecondsBetweenRestarts = 30,
 
    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
 
    Restart = permanent,
    Shutdown = 6000,
 
    EBrainSrv = {ebrain_srv, {ebrain_srv, start_link, []},
        Restart, Shutdown, worker, []},
 
    {ok, {SupFlags, [EBrainSrv]}}.