class S_Nod_EVA extends Rx_Mutator;

function bool CheckReplacement(Actor Other)
{
    local Rx_Building Building;

    ForEach `WorldInfoObject.AllActors(class'Rx_Building', Building)
    {
        if(Building.Class == class'Rx_Building_AirTower')
            Building.BuildingInternalsClass=class'S_Building_AirTower_Internals';
        
        if(Building.Class == class'Rx_Building_AirTower_Ramps')
            Building.BuildingInternalsClass=class'S_Building_AirTower_Internals_Ramps';
        
        if(Building.Class == class'Rx_Building_HandOfNod' || Building.Class == class'Rx_Building_HandOfNod_Ramps')
            Building.BuildingInternalsClass=class'S_Building_HandOfNod_Internals';
        
        if(Building.Class == class'Rx_Building_Refinery_Nod' || Building.Class == class'Rx_Building_Refinery_Nod_Ramps')
            Building.BuildingInternalsClass=class'S_Building_Refinery_Nod_Internals';
        
        if(Building.Class == class'Rx_Building_PowerPlant_Nod' || Building.Class == class'Rx_Building_PowerPlant_Nod_Ramps')
            Building.BuildingInternalsClass=class'S_Building_PowerPlant_Nod_Internals';
        
        if(Building.Class == class'Rx_Building_Obelisk')
            Building.BuildingInternalsClass=class'S_Building_Obelisk_Nod_Internals';
        
        if(Building.Class == class'Rx_Building_Silo')
            Building.BuildingInternalsClass=class'S_Building_Silo_Internals';
        
        if(Building.Class == class'Rx_Building_CommCentre')
            Building.BuildingInternalsClass=class'S_Building_CommCentre_Internals';
    }

 /*  if(Rx_Vehicle_Harvester(Other) != None )
    {
            Rx_Vehicle_Harvester(Other).AttackedEvaSounds[0] = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterUnderAttackCue';
            Rx_Vehicle_Harvester(Other).AttackedEvaSounds[1] = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterUnderAttackCue';
            Rx_Vehicle_Harvester(Other).AttackedEvaSounds[2] = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterUnderAttackCue';
            Rx_Vehicle_Harvester(Other).AttackedEvaSounds[3] = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterUnderAttackCue';
            Rx_Vehicle_Harvester(Other).DestroyedEvaSounds[0] = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterDestroyedCue';
            Rx_Vehicle_Harvester(Other).DestroyedEvaSounds[1] = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterDestroyedCue';
            Rx_Vehicle_Harvester(Other).DestroyedEvaSounds[2] = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterDestroyedCue';
            Rx_Vehicle_Harvester(Other).DestroyedEvaSounds[3] = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterDestroyedCue';
    }*/

    return true;
}
/*    AttackedEvaSounds(0) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterUnderAttackCue'
    AttackedEvaSounds(1) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterUnderAttackCue'
    AttackedEvaSounds(2) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterUnderAttackCue'
    AttackedEvaSounds(3) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterUnderAttackCue'
    
    

    DestroyedEvaSounds(0) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterDestroyedCue'
    DestroyedEvaSounds(1) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterDestroyedCue'
    DestroyedEvaSounds(2) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterDestroyedCue'
    DestroyedEvaSounds(3) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterDestroyedCue'*/