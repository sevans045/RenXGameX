class S_Building_AirTower_BlackHand extends Rx_Building_AirTower;

DefaultProperties
{
   	TeamID = TEAM_GDI
	BuildingInternalsClass  = S_Building_AirTower_Internals_BlackHand

	Begin Object Name=Static_Exterior
        StaticMesh = StaticMesh'S_BU_AirStrip.Mesh.AirTower_Exterior'
    End Object

    Begin Object Name=Static_Interior
        StaticMesh = StaticMesh'S_BU_AirStrip.Mesh.AirTower_Interior'
    End Object

    Begin Object Name=PT_Screens
        StaticMesh = StaticMesh'S_BU_AirStrip.Mesh.SM_AirTower_Screens'
    End Object

    Begin Object Name=SpotLightComponent1
        Translation = (X=477.568085,Y=0.909855,Z=-63.726059)
        Rotation    = (Pitch=0,Yaw=32768,Roll=0)
        LightColor  = (B=255,G=0,R=0,A=0)
    End Object
    SpotLightComponents.Add(SpotLightComponent1)
    Components.Add(SpotLightComponent1)

    Begin Object Name=SpotLightComponent2
        Translation = (X=67.538994,Y=-349.838287,Z=-63.726059)
        Rotation    = (Pitch=0,Yaw=4413,Roll=0)
        LightColor  = (B=255,G=0,R=0,A=0)
    End Object
    SpotLightComponents.Add(SpotLightComponent2)
    Components.Add(SpotLightComponent2)

    Begin Object Name=SpotLightComponent3
        Translation = (X=107.227089,Y=186.403488,Z=-63.726059)
        Rotation    = (Pitch=0,Yaw=10923,Roll=0)
        LightColor  = (B=255,G=0,R=0,A=0)
    End Object
    SpotLightComponents.Add(SpotLightComponent3)
    Components.Add(SpotLightComponent3)
}