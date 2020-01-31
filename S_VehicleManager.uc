class S_VehicleManager extends Rx_VehicleManager;
 
function bool QueueVehicle(class<Rx_Vehicle> inVehicleClass, Rx_PRI Buyer, int VehicleID)
{
    local VQueueElement NewQueueElement;
   
    if(!IsAllowedToQueueUpAnotherVehicle(Buyer))
    {
        return false;
    }
   
    NewQueueElement.Buyer = Buyer;
    NewQueueElement.VehClass = inVehicleClass;
    NewQueueElement.VehicleID = VehicleID;
    NewQueueElement.Factory = GetNearestProduction(Buyer, NewQueueElement.L, NewQueueElement.R);
   
    if(Buyer.GetTeamNum() == TEAM_NOD)
    {
        NOD_Queue.AddItem(NewQueueElement);
        if (!IsTimerActive('queueWork_NOD'))
        {
           if(bJustSpawnedNodHarv) {
               SetTimer(ProductionDelay+8.0+NodAdditionalAirdropProductionDelay, false, 'queueWork_NOD');
               bJustSpawnedNodHarv = false;
               SetTimer(8.0,false,'SpawnC130');
           } else {          
               SetTimer(ProductionDelay+NodAdditionalAirdropProductionDelay, false, 'queueWork_NOD');
               SpawnC130();
           }
        }
        if( !ClassIsChildOf(inVehicleClass, class'Rx_Vehicle_Harvester') )
        {
            Rx_TeamInfo(Teams[Buyer.GetTeamNum()]).IncreaseVehicleCount();
        }
        ConstructionWarn(0);
       
    }
    else if(Buyer.GetTeamNum() == TEAM_GDI)
    {
        GDI_Queue.AddItem(NewQueueElement);
        if (!IsTimerActive('queueWork_GDI'))
        {
           if(bJustSpawnedNodHarv) {
               SetTimer(ProductionDelay+8.0+GDIAdditionalAirdropProductionDelay, false, 'queueWork_GDI');
               bJustSpawnedGDIHarv = false;
               SetTimer(8.0,false,'SpawnC130GDI');
           } else {          
               SetTimer(ProductionDelay+GDIAdditionalAirdropProductionDelay, false, 'queueWork_GDI');
               SpawnC130GDI();
           }
        }
        if(!ClassIsChildOf(inVehicleClass, class'Rx_Vehicle_Harvester'))
        {
            Rx_TeamInfo(Teams[Buyer.GetTeamNum()]).IncreaseVehicleCount();
        }
        ConstructionWarn(1);       
    }
   
    if(NewQueueElement.Factory != None)
        NewQueueElement.Factory.TriggerEventClass(Class'Rx_SeqEvent_FactoryEvent',NewQueueElement.Buyer.Owner,0);
   
    return true;
}
 
function SpawnC130GDI()
{
    local vector loc;
 
    if(bGDIIsUsingAirdrops || !WeaponsFactory[0].SpawnsC130)
        return;
    if(WeaponsFactory[0] != None) {
        loc = GDI_ProductionPlace.L;       
        loc.z -= 100;
        if ( Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset > 0 )
            loc.z += Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset;
 
        Spawn(class'S_C130',,,loc,WeaponsFactory[0].rotation,,true);
    }
}
 
function Actor SpawnVehicle(VQueueElement VehToSpawn, optional byte TeamNum = -1)
{
 
    local Rx_Vehicle Veh;
    local Vector SpawnLocation;
    local Rx_Chinook_Airdrop AirdropingChinook;
    local vector TempLoc;
    local LinearColor NewColor;
 
    NewColor.R = 0.0;
    NewColor.G = 0.0;
    NewColor.B = 1.0;
    NewColor.A = 1.0;
   
    if (TeamNum < 0)
        TeamNum = VehToSpawn.Buyer.GetTeamNum();
     
     
    switch(TeamNum)
    {
        case TEAM_NOD: // buy for NOD
            if(bNodIsUsingAirdrops)
            {
                TempLoc = VehToSpawn.L;
                if (AirStrip.length > 0)
                    TempLoc.Z -= 500;
                    
                AirdropingChinook = Spawn(class'Rx_Chinook_Airdrop', , , TempLoc, VehToSpawn.R, , false);
                AirdropingChinook.initialize(VehToSpawn.Buyer,VehToSpawn.VehicleID, TeamNum);           
            }
            else
            {
                SpawnLocation = VehToSpawn.L;
                if (Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset > 0 )
                    SpawnLocation.Z += Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset ; 
                    Veh = Spawn(VehToSpawn.VehClass,,, SpawnLocation,VehToSpawn.R,,true);
                            
            }
        break;
        case TEAM_GDI: // buy for GDI
            if(bGDIIsUsingAirdrops)
            {
                TempLoc = GDI_ProductionPlace.L;
                if (WeaponsFactory[0] != None)
                    TempLoc.Z -= 500;
                   
                AirdropingChinook = Spawn(class'Rx_Chinook_Airdrop', , , TempLoc, GDI_ProductionPlace.R, , false);
                AirdropingChinook.initialize(VehToSpawn.Buyer,VehToSpawn.VehicleID, TeamNum);          
            }
            else
            {
                SpawnLocation = GDI_ProductionPlace.L;
                if (Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset > 0 )
                    SpawnLocation.Z += Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset ;
                    Veh = Spawn(VehToSpawn.VehClass,,, SpawnLocation,GDI_ProductionPlace.R,,true);
                    Veh.Mesh.CreateAndSetMaterialInstanceConstant(0).SetVectorParameterValue('Camo_Colour', NewColor);
            }
        break;
    }Veh.Mesh.CreateAndSetMaterialInstanceConstant(0).SetVectorParameterValue('Camo_Colour', NewColor);
 
    if (AirdropingChinook != none  )
    {
        if(VehToSpawn.Buyer != None)
        {
            `LogRxPub("GAME" `s "Purchase;" `s "vehicle" `s VehToSpawn.VehClass.name `s "by" `s `PlayerLog(VehToSpawn.Buyer));
            if (Rx_Controller(VehToSpawn.Buyer.Owner) != None)
                Rx_Controller(VehToSpawn.Buyer.Owner).clientmessage("Your vehicle is being delivered!", 'Vehicle');
        }
        else
            `LogRxPub("GAME" `s "Spawn;" `s "vehicle" `s class'Rx_Game'.static.GetTeamName(TeamNum) $ "," $ VehToSpawn.VehClass.name);
           
        return AirdropingChinook;  
    }
 
    if (Veh != none  )
    {
        lastSpawnedVehicle = Veh;
        //Veh.PlaySpawnEffect();
     
        if(VehToSpawn.Buyer != None)
        {
            `LogRxPub("GAME" `s "Purchase;" `s "vehicle" `s VehToSpawn.VehClass.name `s "by" `s `PlayerLog(VehToSpawn.Buyer));
            if (Rx_Controller(VehToSpawn.Buyer.Owner) != None)
                Rx_Controller(VehToSpawn.Buyer.Owner).clientmessage("Your vehicle '"$veh.GetHumanReadableName()$"' is ready!", 'Vehicle');
        }
        else
            `LogRxPub("GAME" `s "Spawn;" `s "vehicle" `s class'Rx_Game'.static.GetTeamName(TeamNum) $ "," $ VehToSpawn.VehClass.name);
     
        InitVehicle(Veh,TeamNum,VehToSpawn.Buyer,VehToSpawn.VehicleID,SpawnLocation);
        if(VehToSpawn.Buyer != None)
            VehToSpawn.Factory.TriggerEventClass(Class'Rx_SeqEvent_FactoryEvent',VehToSpawn.Buyer.Owner,1);
        else
            VehToSpawn.Factory.TriggerEventClass(Class'Rx_SeqEvent_FactoryEvent',Veh,1);
        
            return Veh;
    }
    else if (Veh != none && Rx_Vehicle_Harvester(Veh) != None)
    {
        Veh.DropToGround();
    }
 
    return None;
}
 
function DelayedGDIConstructionWarn() {
    ConstructionWarn(TEAM_GDI);
    SpawnC130GDI();
}
 
DefaultProperties
{
    MessageClass      = class'S_Message_VehicleProduced'
    GDIHarvesterClass = class'S_Vehicle_Harvester_BlackHand'
    NodHarvesterClass = class'S_Vehicle_Harvester_Nod'
}
