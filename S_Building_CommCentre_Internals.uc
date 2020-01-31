class S_Building_CommCentre_Internals extends Rx_Building_CommCentre_Internals
	notplaceable;

`define GdiCapSound	FriendlyBuildingSounds[BuildingRepaired]
`define GdiLostSound	FriendlyBuildingSounds[BuildingDestroyed]
`define GdiUnderAttackForGdiSound FriendlyBuildingSounds[BuildingUnderAttack]
`define GdiUnderAttackForNodSound FriendlyBuildingSounds[BuildingDestructionImminent]
`define NodUnderAttackForGdiSound EnemyBuildingSounds[BuildingUnderAttack]
`define NodUnderAttackForNodSound EnemyBuildingSounds[BuildingDestructionImminent]  

DefaultProperties
{
	`GdiCapSound	= SoundNodeWave'RX_EVA_VoiceClips.Nod_EVA.S_EVA_Nod_TechBuilding_Captured'
	`GdiLostSound	= SoundNodeWave'RX_EVA_VoiceClips.Nod_EVA.S_EVA_Nod_TechBuilding_Lost'

	`GdiUnderAttackForGdiSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_CommCenterUnderAttack'
	`GdiUnderAttackForNodSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_EnemyCommCenterUnderAttack'

	`NodUnderAttackForGdiSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_EnemyCommCenterUnderAttack'
	`NodUnderAttackForNodSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_CommCenterUnderAttack'
}
