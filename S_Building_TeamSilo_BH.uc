class S_Building_TeamSilo_BH extends Rx_Building_TeamSilo_Nod
	placeable;

simulated function String GetHumanReadableName()
{
	return "BH Silo";
}

defaultproperties
{
   TeamID = TEAM_GDI
   BuildingInternalsClass = S_Building_TeamSilo_BH_Internals
   bSignificant		= false

	
	Begin Object Name=Static_Exterior
        Materials[0]=MaterialInstanceConstant'S_BU_TeamSilo.Materials.MI_ModularWall_A_Silo_Nod_DMG0'
        Materials[3]=MaterialInstanceConstant'S_BU_TeamSilo.Materials.MI_ModularWall_A_Silo_Nod_DMG0'
	End Object
	
	Begin Object Name=Static_Interior
        Materials[0]=MaterialInstanceConstant'S_BU_TeamSilo.Materials.MI_ModularWall_A_Silo3_Nod_DMG0'
        Materials[2]=MaterialInstanceConstant'S_BU_TeamSilo.Materials.MI_ModularWall_A_Silo3_Nod_DMG0'
        Materials[3]=MaterialInstanceConstant'S_BU_TeamSilo.Materials.MI_ModularWall_A_Silo3_Nod_DMG0'
    End Object

}

