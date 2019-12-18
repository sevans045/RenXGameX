class S_PurchaseSystem extends Rx_PurchaseSystem;

simulated function bool IsStealthBlackHand(Rx_PRI pri)
{
	if (pri.CharClassInfo == class'Rx_FamilyInfo_Nod_StealthBlackHand' || pri.CharClassInfo == class'S_FamilyInfo_BlackHand_StealthBlackHand') return true;

	return false;
}

DefaultProperties
{
	GDIItemClasses[0]  = class'Rx_Weapon_NukeBeacon'
	GDIItemClasses[1]  = class'S_Weapon_Airstrike_BH'
	GDIItemClasses[2]  = class'Rx_Weapon_RepairTool'
	NodItemClasses[1]  = class'S_Weapon_Airstrike_Nod'
}