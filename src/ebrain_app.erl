-module(ebrain_app).
 
-behaviour(application).
 
%% Application callbacks
-export([start/0, start/2, stop/1]).
 
%% ===================================================================
%% Application callbacks
%% ===================================================================
 
start() ->
    application:start(ebrain).
 
start(_StartType, _StartArgs) ->
    ebrain_sup:start_link().
 
stop(_State) ->
    ok.