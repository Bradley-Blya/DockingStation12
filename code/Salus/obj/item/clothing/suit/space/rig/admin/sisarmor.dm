/obj/item/clothing/suit/space/salus/admin/sisarmor
	name = "Martyred Lady Armor"
	desc = "Powerful armor meant for use by the Sisters."
	icon = 'icons/salus/mob/suit.dmi'
	icon_override = 'icons/salus/mob/suit.dmi'
	icon_state = "sisarmor"
	item_state = "sisarmor"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE


/obj/item/clothing/gloves/salus/admin/sisarmor
	name = "Martyred Lady Gloves"
	desc = "Powerful armor meant for use by the Sisters."
	icon = 'icons/salus/mob/hands.dmi'
	icon_override = 'icons/salus/mob/hands.dmi'
	icon_state = "sisgloves"
	item_state = "sisgloves"



/obj/item/clothing/shoes/salus/admin/sisarmor
	name = "Sister Armor"
	desc = "Powerful armor meant for use by the Sisters."
	icon = 'icons/salus/mob/feet.dmi'
	icon_override = 'icons/salus/mob/feet.dmi'
	icon_state = "sisboots"
	item_state = "sisboots"
	permeability_coefficient = 0.05
	flags = NOSLIP


/obj/item/clothing/head/helmet/space/salus/admin/sisarmor
	name = "Sister Armor"
	desc = "Powerful armor meant for use by the Sisters."
	icon = 'icons/salus/mob/head.dmi'
	icon_override = 'icons/salus/mob/head.dmi'
	icon_state = "sishelm"
	item_state = "sishelm"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE


/obj/item/weapon/storage/backpack/salus/admin/sisarmor/pwrpack
	name = "Sister Armor"
	desc = "Powerful armor meant for use by the Sisters."
	icon = 'icons/salus/mob/back.dmi'
	icon_override = 'icons/salus/mob/back.dmi'
	icon_state = "sispwrpack"
	item_state = "sispwrpack"