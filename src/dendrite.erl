-module(dendrite).
 
%%% Receives signal another neuron
 
-include("ebrain.hrl").
 
-export([new/1, connect/2]).
 
new(Neuron) ->
    #dendrite{owner_neuron = Neuron}.
 
connect(Neuron, Dendrite) ->
    Neuron ! {dendrite_connected, Dendrite#dendrite.owner_neuron},
    Dendrite#dendrite{connected_neuron = Neuron}.