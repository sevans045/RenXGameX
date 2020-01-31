class S_Vehicle_Harvester_BlackHand extends Rx_Vehicle_Harvester
    placeable;

function BroadcastAttack()
{
	BroadcastLocalizedMessage(class'S_Message_Harvester',0,self.PlayerReplicationInfo);
}

function BroadcastDestroyed()
{
	local Rx_Controller PC; 
	
	foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
		{
			if (PC.GetTeamNum() == GetTeamNum())
			{
				PC.CTextMessage(Caps("Harvester Lost"),'Red',180, 1);
			}
			else
			{
				PC.CTextMessage(Caps("Enemy Harvester Destroyed"),'Green',180,1);
				//If we were actually being hit by the enemy team, give the team bonus 
				if(DamagingParties.length > 0)
					PC.DisseminateVPString("[Team Harvester Kill Bonus]&" $ class'Rx_VeterancyModifiers'.default.Ev_HarvesterDestroyed $ "&");
			}
		}

	BroadcastLocalizedMessage(class'S_Message_Harvester',1,self.PlayerReplicationInfo);
}

DefaultProperties
{

	AttackedEvaSounds(0) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterUnderAttackCue'
	AttackedEvaSounds(1) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterUnderAttackCue'
	AttackedEvaSounds(2) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterUnderAttackCue'
	AttackedEvaSounds(3) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterUnderAttackCue'
	
	

	DestroyedEvaSounds(0) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterDestroyedCue'
	DestroyedEvaSounds(1) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterDestroyedCue'
	DestroyedEvaSounds(2) = SoundCue'S_EVA_VoiceClips.S_CABAL_EnemyHarvesterDestroyedCue'
	DestroyedEvaSounds(3) = SoundCue'S_EVA_VoiceClips.S_CABAL_HarvesterDestroyedCue'

//========================================================\\
//*************** Vehicle Visual Properties **************\\
//========================================================\\

	TeamNum = 0
    Begin Object name=SVehicleMesh
        Materials(0)=MaterialInstanceConstant'S_VehicleCamos.Materials.MI_VH_Harvester_Nod'
    End Object
    
}
