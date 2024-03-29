class S_VehicleManager extends Rx_VehicleManager;
 
function Rx_Building_VehicleFactory GetNearestProduction(Rx_PRI Buyer, out Vector loc, out Rotator rot, optional byte TeamNum)
{
    local int i;
    local float BestDist,CurDist;
    local Rx_Building_VehicleFactory BestFactory;
    local bool bActiveBuildingAvailable;

    if(Buyer == None) // Probably Harvy
    {
        if(TeamNum == TEAM_GDI)
        {
            for(i=0; i<WeaponsFactory.length;i++)
            {
                if(BestFactory == None)
                {
                    BestDist = VSizeSq(GDITibPoint.Location - WeaponsFactory[i].location);
                    BestFactory = WeaponsFactory[i];
                    if(!WeaponsFactory[i].IsDestroyed())
                        bActiveBuildingAvailable = true;
                }
                else if ((bActiveBuildingAvailable && !WeaponsFactory[i].IsDestroyed()) || (!bActiveBuildingAvailable))
                {
                    CurDist = VSizeSq(GDITibPoint.Location - WeaponsFactory[i].location);
                    if(BestDist > CurDist)
                    {
                        BestDist = CurDist;
                        BestFactory = WeaponsFactory[i];
                    }
                    if(!bActiveBuildingAvailable &&!WeaponsFactory[i].IsDestroyed())
                        bActiveBuildingAvailable = true;
                }
            }
            BestFactory.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_DropOff', loc, rot);
        }   
        else if(TeamNum == TEAM_NOD)
        {
            for(i=0; i<Airstrip.length;i++)
            {
                if(BestFactory == None)
                {
                    BestDist = VSizeSq(NodTibPoint.Location - Airstrip[i].location);
                    BestFactory = Airstrip[i];
                    if(!AirStrip[i].IsDestroyed())
                        bActiveBuildingAvailable = true;            
                }
                else if ((bActiveBuildingAvailable && !AirStrip[i].IsDestroyed()) || (!bActiveBuildingAvailable))
                {
                    CurDist = VSizeSq(NodTibPoint.Location - Airstrip[i].location);
                    if(BestDist > CurDist)
                    {
                        BestDist = CurDist;
                        BestFactory = Airstrip[i];
                        if(!bActiveBuildingAvailable && !AirStrip[i].IsDestroyed())
                            bActiveBuildingAvailable = true;
                    }
                }
            }
            BestFactory.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_DropOff', loc, rot);
        }       
    }

    else if(Buyer.GetTeamNum() == TEAM_GDI)
    {           
        for(i=0; i<WeaponsFactory.length;i++)
        {
            if(BestFactory == None)
            {
                BestDist = VSizeSq(Controller(Buyer.Owner).Pawn.Location - WeaponsFactory[i].location);
                BestFactory = WeaponsFactory[i];
                if(!WeaponsFactory[i].IsDestroyed())
                    bActiveBuildingAvailable = true;
            }
            else if ((bActiveBuildingAvailable && !WeaponsFactory[i].IsDestroyed()) || (!bActiveBuildingAvailable))
            {
                CurDist = VSizeSq(Controller(Buyer.Owner).Pawn.Location - WeaponsFactory[i].location);
                if(BestDist > CurDist)
                {
                    BestDist = CurDist;
                    BestFactory = WeaponsFactory[i];
                }
                if(!bActiveBuildingAvailable &&!WeaponsFactory[i].IsDestroyed())
                    bActiveBuildingAvailable = true;
            }
        }
        BestFactory.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_DropOff', loc, rot);
    }
    else if(Buyer.GetTeamNum() == TEAM_NOD)
    {
        for(i=0; i<Airstrip.length;i++)
        {
            if(BestFactory == None)
            {
                BestDist = VSizeSq(Controller(Buyer.Owner).Pawn.Location - Airstrip[i].location);
                BestFactory = Airstrip[i];
                if(!AirStrip[i].IsDestroyed())
                    bActiveBuildingAvailable = true;            
            }
            else if ((bActiveBuildingAvailable && !AirStrip[i].IsDestroyed()) || (!bActiveBuildingAvailable))
            {
                CurDist = VSizeSq(Controller(Buyer.Owner).Pawn.Location - Airstrip[i].location);
                if(BestDist > CurDist) 
                {
                    BestDist = CurDist;
                    BestFactory = Airstrip[i];
                    if(!bActiveBuildingAvailable && !AirStrip[i].IsDestroyed())
                        bActiveBuildingAvailable = true;
                }
            }
        }
        BestFactory.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_DropOff', loc, rot);

    }
    if(BestFactory != None)
        return BestFactory;

        return None;

}

function QueueHarvester(byte team, bool bWithIncreasedDelay)
{
    local VQueueElement NewQueueElement;
    
    NewQueueElement.Buyer = None;

    if(team == TEAM_NOD) 
    {
        if(bNodRefDestroyed)
            return;

        if(Airstrip.Length > 0)
            NewQueueElement.Factory = GetNearestProduction(None,NewQueueElement.L,NewQueueElement.R,team);
        else
        {
            NewQueueElement.L = NOD_ProductionPlace.L;
            NewQueueElement.R = NOD_ProductionPlace.R;          
        }
        NewQueueElement.VehClass  = NodHarvesterClass;
        NewQueueElement.VehicleID = 255;//8;
        NOD_Queue.AddItem(NewQueueElement);
        if (!IsTimerActive('queueWork_NOD'))
        {
           if(bWithIncreasedDelay)
           {
             SetTimer(ProductionDelay + 10.0, false, 'queueWork_NOD');
             if(!AreTeamFactoriesDestroyed(TEAM_NOD))
                SetTimer(10.0,false,'SpawnC130');
           }
           else
           {
             if(!AreTeamFactoriesDestroyed(TEAM_NOD))
                SpawnC130();
             SetTimer(ProductionDelay, false, 'queueWork_NOD'); 
           }
        }
    } 
    else if(team == TEAM_GDI) 
    {
        if(bGDIRefDestroyed)
            return;
 
        if(WeaponsFactory.Length > 0)
            NewQueueElement.Factory = GetNearestProduction(None,NewQueueElement.L,NewQueueElement.R,team);      
        else
        {
            NewQueueElement.L = GDI_ProductionPlace.L;
            NewQueueElement.R = GDI_ProductionPlace.R;          
        }       

        NewQueueElement.VehClass  = GDIHarvesterClass;
        NewQueueElement.VehicleID = 254 ;//7;
        GDI_Queue.AddItem(NewQueueElement);
        if (!IsTimerActive('queueWork_GDI'))
        {          
           if(bWithIncreasedDelay)
           {
             SetTimer(ProductionDelay + 10.0, false, 'queueWork_GDI');
                if(!AreTeamFactoriesDestroyed(TEAM_GDI))
                SetTimer(10.0,false,'SpawnC130GDI');
           }
           else
           {
             if(!AreTeamFactoriesDestroyed(TEAM_GDI))
                SpawnC130GDI();
             SetTimer(ProductionDelay, false, 'queueWork_GDI'); 
           }           
        }       
    }       
}

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

function SpawnC130() 
{
    local vector loc;
    local rotator C130Rot;

    if(bNodIsUsingAirdrops || !NOD_Queue[0].Factory.SpawnsC130)
        return;
    if(AirStrip.Length > 0) 
    {
          loc = NOD_Queue[0].L;     
          loc.z -= 100;
          C130Rot = NOD_Queue[0].R;
          C130Rot.yaw += 32768; 
        if ( Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset > 0 )
            loc.z += Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset;

            Spawn(class'Rx_C130',,,loc,C130Rot,,true);
            `log("C130 Nod spawn: loc" `s loc `s "C130Rot" `s C130Rot);
    }
}
 
function SpawnC130GDI() 
{
    local vector loc;
    local rotator C130Rot;

    if(bGDIIsUsingAirdrops || !GDI_Queue[0].Factory.SpawnsC130)
        return;
    if(AirStrip.Length > 0) 
    {
          loc = GDI_Queue[0].L;     
          loc.z -= 100;
          C130Rot = GDI_Queue[0].R;
          C130Rot.yaw += 32768; 
        if ( Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset > 0 )
            loc.z += Rx_MapInfo(WorldInfo.GetMapInfo()).NodAirstripDropoffHeightOffset;

            Spawn(class'S_C130',,,loc,C130Rot,,true);
            `log("C130 GDI spawn: loc" `s loc `s "C130Rot" `s C130Rot);
    }
}
 
function Actor SpawnVehicle(VQueueElement VehToSpawn, optional byte TeamNum = -1)
{
 
    local Rx_Vehicle Veh;
    local Vector SpawnLocation;
    local Rx_Chinook_Airdrop AirdropingChinook;
    local vector TempLoc;
   
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
    }
 
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
