/obj/item/clothing/suit/space/salus/admin

	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/cell)
	slowdown = 0
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 30, rad = 30)
	siemens_coefficient = 0.2

//	var/internals_tank_type = /obj/item/weapon/tank/admin_tank
//	var/internals_tank

	//For locking the suit
	var/initialized = 0
	var/obj/item/clothing/head/helmet/space/salus/admin/helmetcp
	var/mob/living/carbon/human/affecting = null



/obj/item/clothing/suit/space/salus/admin/New()
	..()
//	internals_tank = new internals_tank_type
	verbs += /obj/item/clothing/suit/space/salus/admin/proc/init


/obj/item/clothing/head/helmet/space/salus/admin

	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 30, rad = 30)
	siemens_coefficient = 0.2

	//For locking the suit
	var/initialized = 0
	var/obj/item/clothing/suit/space/salus/admin/suitcp


/obj/item/clothing/head/helmet/space/salus/admin/New()
	..()



/obj/item/clothing/suit/space/salus/admin/proc/init()
	set name = "Initialize Suit"
	set desc = "Initializes the suit for field operation."
	set category = "Salus Equip"

	ninitialize()
	return

/obj/item/clothing/suit/space/salus/admin/proc/deinit()
	set name = "Initialize Suit"
	set desc = "Initializes the suit for field operation."
	set category = "Salus Equip"

	deinitialize()
	return


/obj/item/clothing/suit/space/salus/admin/proc/ninitialize(mob/living/carbon/human/U = loc)
	if(U.mind && U.client.holder && !initialized)
		for(var/i,i<7,i++)
			switch(i)
				if(0)
					U << "\blue Now initializing . . ."
				if(1)
					if(!lock_suit(U))//Locking the suit onto the user
						break
					U << "\blue Securing external locking mechanism . . . \nNeutral-net established."
				if(2)
					U << "\blue Extending neural-net interface . . . \nNow monitoring brain wave pattern . . ."
				if(3)
					if(U.stat==2||U.health<=0)
						U << "\red <B>FĆAL �Rr�R</B>: 344--93#�&&21 BR��N |/|/aV� PATT$RN <B>RED</B>\nA-A-aB�rT�NG..."
						unlock_suit()
						break
					lock_suit(U,1)//Check for icons.
					U.regenerate_icons()
					U << "\blue Linking neural-net interface...\nPattern \green <B>GREEN</B>\blue, continuing operation."
				if(4)
					U << "\blue Primary system status: <B>ONLINE</B>.\nBackup system status: <B>ONLINE</B>."
				if(5)
					U << "\blue All systems nominal. Welcome to <B>AdminOS</B>, [U.real_name]."
					grant_nt_equip_verbs()
					initialized = 1
			sleep(10)


	else
		if(U.mind && !U.client.holder)
			U << "Warning: Unauthorized use of Nanotrasen Equipment detected. User has exactly 10 seconds before termination of equipment along with user."
			spawn(100)
				if(src.loc == U)
					U << "Commencing Termination of equipment and user."
					spawn(10)
						U.gib()
						message_admins("\blue [key_name(src)] has been gibbed for attempting to use an Admin Hardsuit.")
		else if(initialized)
			U << "\red The suit is already functioning. \black <b>Please report this bug.</b>"
		else
			U << "\red <B>ERROR</B>: \black You cannot use this function at this time."
	return

/obj/item/clothing/suit/space/salus/admin/proc/deinitialize()
	if(affecting == loc)
		var/mob/living/carbon/human/U = affecting
		if(!initialized)
			U << "\red The suit is not initialized. \black <b>Please report this bug.</b>"
			return
		if(alert("Are you certain you wish to deinitialize the suit? This will disengage life support and allow the suit to be removed.",,"Yes","No")=="No")
			return
		for(var/i = 0,i<7,i++)
			switch(i)
				if(0)
					U << "\blue Now de-initializing..."
				if(1)
					U << "\blue Logging off, [U:real_name]. Shutting down <B>AdminOS</B>."
				if(2)
					U << "\blue Primary system status: <B>OFFLINE</B>.\nBackup system status: <B>OFFLINE</B>."
				if(3)
					U << "\blue Disconnecting neural-net interface...\green<B>Success</B>\blue."
				if(4)
					U << "\blue Disengaging neural-net interface...\green<B>Success</B>\blue."
				if(5)
					U << "\blue Unsecuring external locking mechanism...\nNeural-net abolished.\nOperation status: <B>FINISHED</B>."
					unlock_suit()
					remove_nt_equip_verbs()
					initialized = 0
			sleep(5)
	return

/obj/item/clothing/suit/space/salus/admin/proc/lock_suit(mob/living/carbon/human/U)
	if(!U)	return
	if(!U.client.holder)
		U << "Warning: Unauthorized use of Nanotrasen Equipment detected. User has exactly 10 seconds before termination of equipment along with user."
		spawn(100)
			if(src.loc == U)
				U << "Commencing Termination of equipment and user."
				spawn(10)
					U.gib()

	if(!istype(U.head, /obj/item/clothing/head/helmet/space/salus/admin))
		U << "\red <B>ERROR</B>: 100113 \black UNABLE TO LOCATE HEAD GEAR\nABORTING..."
		return 0

	affecting = U
	canremove = 0
	slowdown = 0
	helmetcp = U.head
	helmetcp.canremove = 0
	helmetcp.suitcp = src

	return 1


/obj/item/clothing/suit/space/salus/admin/proc/unlock_suit(mob/living/carbon/human/U)
	affecting = null
	canremove = 1
	slowdown = 1
	helmetcp.canremove = 1


/obj/item/clothing/suit/space/salus/admin/proc/grant_nt_equip_verbs()
	verbs -= /obj/item/clothing/suit/space/salus/admin/proc/init
	verbs += /obj/item/clothing/suit/space/salus/admin/proc/deinit


/obj/item/clothing/suit/space/salus/admin/proc/remove_nt_equip_verbs()
	verbs += /obj/item/clothing/suit/space/salus/admin/proc/init
	verbs -= /obj/item/clothing/suit/space/salus/admin/proc/deinit

/mob/living/carbon/human/proc/isAdminSuitInit(var/m_player)
	if(!m_player)	return 0
	var/mob/living/carbon/human/H = m_player
	if(!H.wear_suit) 	return 0
	if(!istype(H.wear_suit, /obj/item/clothing/suit/space/salus/admin))	return 0
	var/obj/item/clothing/suit/space/salus/admin/S
	if(istype(H.wear_suit, /obj/item/clothing/suit/space/salus/admin))
		S = H.wear_suit
	if(S.initialized == 1)
		return 1
	else
		return 0
