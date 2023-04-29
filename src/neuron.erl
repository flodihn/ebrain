-module(neuron).
 
-record(neuron, {fatigue, current_charge, charge_treshold = 1.0, axon, dendrites}).
 
-export([create/0]).
 
%% Internal exports
-export([loop/1]).
 
create() ->
    Axon = axon:new(self()),
    Neuron = #neuron{
        fatigue = 0.0,
        current_charge = -1.0,
        charge_treshold = 1.0,
        axon = Axon,
        dendrites = []},
    loop(Neuron).
 
loop(#neuron{
        axon = Axon,
        fatigue = Fatigue,
        charge_treshold = ChargeTreshhold,
        current_charge = CurrentCharge} = Neuron) ->
    receive
        {charge, Charge} ->
            NewCharge = CurrentCharge + Charge,
            case NewCharge > ChargeTreshhold of
                true ->
                    Axon:fire(),
                    loop(Neuron#neuron{fatigue = 1.0});
                false ->
                    loop(Neuron)
            end;
        {dendrite_connected, OtherNeuron} ->
            UpdatedAxon = axon:add_connection(OtherNeuron, Axon),
            loop(Neuron#neuron{axon = UpdatedAxon});
        upgrade ->
            ?MODULE:loop(Neuron)
    after 1 ->
        case Fatigue > 0.0 of
            false ->
                loop(Neuron);
            true ->
                loop(Neuron#neuron{fatigue = Fatigue - 0.01})
        end
    end.