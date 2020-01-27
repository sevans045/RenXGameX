class S_Game extends Rx_Game;

event InitGame(string Options, out string ErrorMessage)
{
    super.InitGame(Options, ErrorMessage);
    AddMutator("RenX_GameX.S_Nod_EVA");
    BaseMutator.InitMutator(Options, ErrorMessage);
}

function static string GetTeamName(byte Index)
{
	switch (Index)
	{
	case TEAM_GDI:
		return "Black Hand";
	case TEAM_NOD:
		return "Nod";
	default:
		return "Neutral";
	}
}

DefaultProperties
{
	VehicleManagerClass = class'S_VehicleManager'
	HUDClass = class'S_HUD'
	PlayerControllerClass = class'S_Controller'
	PurchaseSystemClass = class'S_PurchaseSystem'
	TeamInfoClass = class'S_TeamInfo'
	PlayerReplicationInfoClass = class'S_PRI'
}