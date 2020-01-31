class S_Building_Silo_Internals extends Rx_Building_Silo_Internals
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

	`GdiUnderAttackForGdiSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_TibSiloUnderAttack'
	`GdiUnderAttackForNodSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_EnemyTibSiloUnderAttack'

	`NodUnderAttackForGdiSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_EnemyTibSiloUnderAttack'
	`NodUnderAttackForNodSound = SoundNodeWave'S_EVA_VoiceClips.S_CABAL_TibSiloUnderAttack'
}
