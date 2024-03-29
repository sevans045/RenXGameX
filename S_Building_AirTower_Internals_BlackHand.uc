class S_Building_AirTower_Internals_BlackHand extends Rx_Building_AirTower_Internals
	notplaceable;

function FindAirStrip()
{
	local S_Building_AirStrip_BlackHand strip;
	ForEach AllActors(class'S_Building_AirStrip_BlackHand',strip)
	{
		strip.RegsiterTowerInternals(self);
		if (AirstripInternals == None)
			AirstripInternals = S_Building_AirStrip_Internals_BlackHand(strip.BuildingInternals);
		break; // found Air Strip no need to search anymore
	}
}

DefaultProperties
{
	TeamID = TEAM_GDI
	FriendlyBuildingSounds(BuildingDestroyed)           = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_AirStripDestroyed'
	FriendlyBuildingSounds(BuildingUnderAttack)         = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_AirStripUnderAttack'
	FriendlyBuildingSounds(BuildingRepaired)            = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_AirStripRepaired'
	EnemyBuildingSounds(BuildingDestroyed)              = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_EnemyAirStripDestroyed'
	EnemyBuildingSounds(BuildingUnderAttack)            = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_EnemyAirStripUnderAttack'
}