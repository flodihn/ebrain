-module(neuron_hub).
 
%% Creates a concentration of neurons (similar to a layer).
 
-export([
    create/1
]).
 
-record(state, {neurons}).
 
create(InitialNrNeurons) ->
    create_neurons(InitialNrNeurons, #state{}).
 
create_neurons(0, State) ->
    {ok, State};
 
create_neurons(NumNeurons, #state{neurons = Neurons} = State) ->
    {ok, Pid} = spawn_link(neuron, create, []),
    create_neurons(NumNeurons - 1, State#state{neurons = [Pid | Neurons]}).