//To be used with the Admin Hardsuit (Nanotrasen Representative Hardsuits)
/obj/item/weapon/tank/admin_tank
	name = "oxygen tank"
	desc = "A tank of oxygen."
	icon_state = "oxygen"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD

	volume = 9999
	integrity = 9999


	New()
		..()
		//src.air_contents.oxygen = (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
		air_contents.adjust((6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))
		return
