/obj/item/weapon/erp
	name = "Bad Dragon"
	icon = 'icons/Axiom/obj/weapons/erp.dmi'
	icon_state = "dragon_dildo"
	desc = "A large, floppy, pointed, flesh-like thing."

/obj/item/weapon/erp/attack(atom/A, mob/user as mob)
	user.visible_message("<B>[user]</B> penetrates <B>[A]</B> with the Bad Dragon!")