class S_Vehicle_Harvester_Nod extends Rx_Vehicle_Harvester_Nod
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

}
