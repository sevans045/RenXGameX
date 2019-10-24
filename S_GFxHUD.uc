class S_GFxHUD extends Rx_GFxHud;

exec function UpdateHUDVars() 
{
	// Grease:	When you have two frames, and an object in each frame with the same name,
	//			the variables HAVE to be updated, otherwise it will only change the object
	//			from frame 1, even if you're in frame 2.

	// Shahman: in UT (GFxMinimapHud), what epic did is to call the GFxMoviePlayer's gotoandstop function and reupdate.

	//Health
	HealthBar       = GetVariableObject("_root.HealthBlock.Health");
	HealthN         = GetVariableObject("_root.HealthBlock.HealthText.HealthN");
	HealthMaxN      = GetVariableObject("_root.HealthBlock.HealthText.HealthMaxN");
	HealthBlock     = GetVariableObject("_root.HealthBlock");
	HealthText      = GetVariableObject("_root.HealthBlock.HealthText");
	HealthIcon      = GetVariableObject("_root.HealthBlock.HealthIcon");

	//Armor
	ArmorBar        = GetVariableObject("_root.HealthBlock.Armor");
	ArmorN          = GetVariableObject("_root.HealthBlock.ArmorN");
	ArmorMaxN       = GetVariableObject("_root.HealthBlock.ArmorMaxN");
	VArmorMaxN      = GetVariableObject("_root.HealthBlock.VehicleMaxN");
	//nBab
	VHealthN         = GetVariableObject("_root.HealthBlock.HealthN");

	//Vehicle
	VArmorN         = GetVariableObject("_root.HealthBlock.VehicleN");
	VArmorBar       = GetVariableObject("_root.HealthBlock.HealthVehicle");
	VehicleMC       = GetVariableObject("_root.WeaponBlock.VehicleIcon");
	VAltWeaponBlock = GetVariableObject("_root.WeaponBlock.AltWeaponBlock");
	VBackdrop       = GetVariableObject("_root.WeaponBlock.VehicleBackdrop");

	//Stamina
	StaminaBar      = GetVariableObject("_root.HealthBlock.Stamina");

	//Weapon and Ammo
	WeaponBlock     = GetVariableObject("_root.WeaponBlock");
	WeaponName      = GetVariableObject("_root.WeaponBlock.WeaponName");
	AmmoInClipN     = GetVariableObject("_root.WeaponBlock.AmmoInClipN");
	AmmoReserveN    = GetVariableObject("_root.WeaponBlock.AmmoReserveN");
	InfinitAmmo     = GetVariableObject("_root.WeaponBlock.Infinity");
	AmmoBar         = GetVariableObject("_root.WeaponBlock.Ammo");
	WeaponMC        = GetVariableObject("_root.WeaponBlock.Weapon");
	WeaponPrevMC    = GetVariableObject("_root.WeaponBlock.WeaponPrev");
	WeaponNextMC    = GetVariableObject("_root.WeaponBlock.WeaponNext");

	AltWeaponName   = GetVariableObject("_root.WeaponBlock.AltWeaponBlock.AltWeaponName");
	AltAmmoInClipN  = GetVariableObject("_root.WeaponBlock.AltWeaponBlock.AltAmmoInClipN");
	AltInfinitAmmo  = GetVariableObject("_root.WeaponBlock.AltWeaponBlock.AltInfinity");
	AltAmmoBar      = GetVariableObject("_root.WeaponBlock.AltWeaponBlock.AltAmmo");

	//Abilities
	AbilityMC       = GetVariableObject("_root.WeaponBlock.Ability");
	AbilityMeterMC  = GetVariableObject("_root.WeaponBlock.Ability.Meter");
	AbilityIconMC   = GetVariableObject("_root.WeaponBlock.Ability.Icon");
	AbilityTextMC	= GetVariableObject("_root.WeaponBlock.AbilityText");

	//Items
	GrenadeMC       = GetVariableObject("_root.WeaponBlock.Grenade");
	GrenadeN        = GetVariableObject("_root.WeaponBlock.Grenade.Icon.TextField");
	TimedC4MC       = GetVariableObject("_root.WeaponBlock.TimedC4");
	RemoteC4MC      = GetVariableObject("_root.WeaponBlock.RemoteC4");
	ProxyC4MC       = GetVariableObject("_root.WeaponBlock.ProxyC4");
	BeaconMC        = GetVariableObject("_root.WeaponBlock.Beacon");

	//Gameplay Info
	BottomInfo      = GetVariableObject("_root.BottomInfo");
	Credits         = GetVariableObject("_root.BottomInfo.Stats.Credits");
	MatchTimer      = GetVariableObject("_root.BottomInfo.Stats.Time");
	VehicleCount    = GetVariableObject("_root.BottomInfo.Stats.Vehicles");
	MineCount    	= GetVariableObject("_root.BottomInfo.Stats.Mines");
	CommPoints      = GetVariableObject("_root.BottomInfo.Stats.CP");

	//Progress Bar
	
	LoadingMeterMC[0] = GetVariableObject("_root.loadingMeterGDI");
	LoadingText[0] = GetVariableObject("_root.loadingMeterGDI.loadingText");
	LoadingBarWidget[0] = GFxClikWidget(GetVariableObject("_root.loadingMeterGDI.bar", class'GFxClikWidget'));
	LoadingMeterMC[1] = GetVariableObject("_root.loadingMeterNod");
	LoadingText[1] = GetVariableObject("_root.loadingMeterNod.loadingText");
	LoadingBarWidget[1] = GFxClikWidget(GetVariableObject("_root.loadingMeterNod.bar", class'GFxClikWidget'));

	HideLoadingBar();
//---------------------------------------------------
	//Radar implementation
	if (Minimap == none)
	{
		Minimap = Rx_GFxMinimap(GetVariableObject("_root.minimap", class'S_GFxMinimap'));
		Minimap.init(self);
	}

	if (Marker == none) {
		Marker = Rx_GFxMarker(GetVariableObject("_root.MarkerContainer", class'Rx_GFxMarker'));
		Marker.init(self);
	}
	if(GrenadeN != None)
		GrenadeN.SetText("0X");
	if(GrenadeMC != None)
		GrenadeMC.GotoAndStopI(2);
	if(TimedC4MC != None)
		TimedC4MC.GotoAndStopI(2);
	if(RemoteC4MC != None)
		RemoteC4MC.GotoAndStopI(2);
	if(ProxyC4MC != None)
		ProxyC4MC.GotoAndStopI(2);
	HideBuildingIcons();
}

DefaultProperties
{
	MovieInfo = SwfMovie'SXHUD.RenXHud'
}