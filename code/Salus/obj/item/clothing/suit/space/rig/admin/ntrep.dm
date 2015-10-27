/*

		Nanotrasen Representative Hardsuit

*/

/obj/item/clothing/suit/space/salus/admin/ntrep
	name = "Nanotrasen Representative Armor"
	desc = "A pressurized suit with a reinforced frame of Tungsten Carbide and several layers of thick Graphene for armor. Only the highest ranking officers amoung the Nanotrasen Administration may wear this."
	icon = 'icons/salus/mob/suit.dmi'
	icon_state = "NT_Rep_Armor"
	item_state = "NT_Rep_Armor"
	icon_override = 'icons/salus/mob/suit.dmi'
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/head/helmet/space/salus/admin/ntrep
	name = "Nanotrasen Representative Helmet"
	desc = "A pressurized helmet with a frame reinforced with Iridium and Tungsten Carbide. Only the highest ranking officers amoung the Nanotrasen Administration may wear this."
	icon = 'icons/salus/mob/head.dmi'
	icon_state = "NT_Rep_Helmet0"
//	item_state = "eng_helm"
	icon_override = 'icons/salus/mob/head.dmi'
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	icon_action_button = "action_hardhat"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight)
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE


	attack_self(mob/user)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]" //To prevent some lighting anomalities.
			return
		on = !on
		icon_state = "NT_Rep_Helmet[on]"
//		item_state = "rig[on]-[color]"

		if(on)	user.SetLuminosity(user.luminosity + brightness_on)
		else	user.SetLuminosity(user.luminosity - brightness_on)
		user.regenerate_icons()

	pickup(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity + brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(0)

	dropped(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity - brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(brightness_on)


/*

		Nanotrasen Hardsuit/Armor

*/

/obj/item/clothing/suit/space/salus/admin/ntarmor
	name = "Nanotrasen Elite Armor"
	desc = "A Nanotrasen brand Elite suit of Armor. It is made with a classified combination of alloys, phoron, and graphene."
	icon = 'icons/salus/mob/suit.dmi'
	icon_state = "NTarmor"
	item_state = "NTarmor"
	icon_override = 'icons/salus/mob/suit.dmi'
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE



/obj/item/clothing/head/helmet/space/salus/admin/ntarmor
	name = "Nanotrasen Elite Helmet"
	desc = "A Nanotrasen brand Elite Helmet. Made with a classified combination of alloys, phoron, and graphene, it is rumored to be impenetratable and fire-resistant."
	icon = 'icons/salus/mob/head.dmi'
	icon_state = "NThelm0"
	item_state = "NThelm0"
	icon_override = 'icons/salus/mob/head.dmi'
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	icon_action_button = "action_hardhat"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight)
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE


	attack_self(mob/user)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]" //To prevent some lighting anomalities.
			return
		on = !on
		icon_state = "NThelm[on]"
//		item_state = "rig[on]-[color]"

		if(on)	user.SetLuminosity(user.luminosity + brightness_on)
		else	user.SetLuminosity(user.luminosity - brightness_on)
		user.regenerate_icons()

	pickup(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity + brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(0)

	dropped(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity - brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(brightness_on)


/*

		Nanotrasen Spec. Ops. Gloves, now with no shocky shocky damage!

*/

/obj/item/clothing/gloves/swat/salus/nt_sr
	name = "Nanotrasen Elite Gloves"
	desc = "Nanotrasen Elite Gloves, lined with thick insulation to prevent electrocutions when dealing with electric issues."
	siemens_coefficient = 0