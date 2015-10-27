/obj/item/clothing/suit/space/salus/admin/spacemarine
	name = "Blood Angel Armor"
	desc = "Powerful armor meant for use by the Space Marines."
	icon = 'icons/salus/mob/suit.dmi'
	icon_override = 'icons/salus/mob/suit.dmi'
	icon_state = "spacemarine"
	item_state = "spacemarine"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE


/obj/item/clothing/gloves/salus/admin/spacemarine
	name = "Blood Angel Gloves"
	desc = "Powerful armor meant for use by the Space Marines."
	icon = 'icons/salus/mob/hands.dmi'
	icon_override = 'icons/salus/mob/hands.dmi'
	icon_state = "spacemarine"
	item_state = "spacemarine"



/obj/item/clothing/shoes/salus/admin/spacemarine
	name = "Blood Angel Boots"
	desc = "Powerful armor meant for use by the Space Marines."
	icon = 'icons/salus/mob/feet.dmi'
	icon_override = 'icons/salus/mob/feet.dmi'
	icon_state = "spacemarine"
	item_state = "spacemarine"
	permeability_coefficient = 0.05
	flags = NOSLIP


/obj/item/clothing/head/helmet/space/salus/admin/spacemarine
	name = "Blood Angel Helmet"
	desc = "Powerful armor meant for use by the Space Marines."
	icon = 'icons/salus/mob/head.dmi'
	icon_override = 'icons/salus/mob/head.dmi'
	icon_state = "spacemarine"
	item_state = "spacemarine"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 55, bomb = 50, bio = 100, rad = 100)
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE


/obj/item/weapon/storage/backpack/salus/admin/spacemarine/pwrpack
	name = "Blood Angel Power Pack"
	desc = "A mini Fusion Reactor within a backpack that is used to power the Space Marine's armor."
	icon = 'icons/salus/mob/back.dmi'
	icon_override = 'icons/salus/mob/back.dmi'
	icon_state = "spacemarinepwrpack"
	item_state = "spacemarinepwrpack"