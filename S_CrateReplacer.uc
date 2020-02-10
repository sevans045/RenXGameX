class S_CrateReplacer extends Rx_Mutator;

function bool CheckReplacement(Actor Other)
{
    if (Rx_CratePickup(Other) != None)
        Rx_CratePickup(Other).DefaultCrateTypes[1] = class'S_CrateType_Spy';

    return true;
}