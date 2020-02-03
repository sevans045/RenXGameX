class S_Building_RepairFacility_BH extends Rx_Building_Nod_RepairFactory
	placeable;

simulated function String GetHumanReadableName()
{
	return "BH Repair Facility";
}

defaultproperties
{
   TeamID = TEAM_GDI
   BuildingInternalsClass = S_Building_RepairFacility_BH_Internals

	Begin Object Name=Static_Interior
		StaticMesh = StaticMesh'RX_BU_RepairPad.Mesh.SM_RepairPad_Nod'
		Materials[0]=MaterialInstanceConstant'S_BU_RepairPad.Materials.MI_RepairPad_Nod'
	End Object
}