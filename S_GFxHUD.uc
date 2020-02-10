class S_GFxHUD extends Rx_GFxHud;

exec function InitializeHUDVars() 
{
	// Grease:	When you have two frames, and an object in each frame with the same name,
	//			the variables HAVE to be updated, otherwise it will only change the object
	//			from frame 1, even if you're in frame 2.

	// Shahman: in UT (GFxMinimapHud), what epic did is to call the GFxMoviePlayer's gotoandstop function and reupdate.

	// Handepsilon: Ok, whoever has the idea of reassigning ALL gfxobject for each necessary update needs some spanking.

	//Items
//	GrenadeMC       = WeaponBlock.GetObject("Grenade");
//	GrenadeN        = WeaponBlock.GetObject("Grenade.Icon.TextField");
//	TimedC4MC       = WeaponBlock.GetObject("TimedC4");
//	RemoteC4MC      = WeaponBlock.GetObject("RemoteC4");
//	ProxyC4MC       = WeaponBlock.GetObject("ProxyC4");
//	BeaconMC        = WeaponBlock.GetObject("Beacon");
	UpdateHealthGFx(,,,true);
	UpdateWeaponGFx(false, true);
	UpdateVeterancyGFx(true);

//	HarvyHealthContainer = StatsMC.GetObject("HarvyCont");
//	HarvyBars = HarvyHealthContainer.GetObject("HarvyHealth");

	VoteMC = GetVariableObject("_root.VoteTextBase");

	//Progress Bar
	UpdateLoadingBar();

	HideLoadingBar();
//---------------------------------------------------
	//Radar implementation
	if (Minimap == none)
	{
		MinimapBase = GetVariableObject("_root.minimapBase");
		CompassMC = MinimapBase.GetObject("CompassMC");
		Minimap = Rx_GFxMinimap(GetVariableObject("_root.minimapBase.minimap", class'S_GFxMinimap'));
		Minimap.init(self);
	}

	if (Marker == none) {
		Marker = Rx_GFxMarker(GetVariableObject("_root.MarkerContainer", class'Rx_GFxMarker'));
		Marker.init(self);
	}
}

DefaultProperties
{
//	MovieInfo = SwfMovie'SXHUD.RenXHud'
}