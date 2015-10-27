/obj/machinery/door/poddoor/salus/multi_tile/three_one_poddoor
	name = "Podlock"
	desc = "Why it no open!!!"
	icon = 'icons/salus/obj/door/1x3blast.dmi'
	icon_state = "pdoor1"
	dir = 1
	explosion_resistance = 75					//Has 5 times as must explosion resistance because it's twice as large as a regular poddoor.
	width = 3
//	var/list/filler_objects = list()


/obj/machinery/door/poddoor/salus/multi_tile/three_one_poddoor/New()
	. = ..()
//	world << "Break 1"
	if(density)
		layer = 3.3		//to override door.New() proc
	else
		layer = initial(layer)
//	world << "Break 2"
	spawn_filler_objects(0)
	setDensity(src.density)
	setOpac(src.opacity)
//	world << "Break 4"
	return


/obj/machinery/door/poddoor/salus/multi_tile/three_one_poddoor/Bumped(atom/AM)
	if(!density)
		return ..()
	else
		return 0

/obj/machinery/door/poddoor/salus/multi_tile/three_one_poddoor/attackby(obj/item/weapon/C as obj, mob/user as mob)
	src.add_fingerprint(user)
	if (!( istype(C, /obj/item/weapon/crowbar) || (istype(C, /obj/item/weapon/twohanded/fireaxe) && C:wielded == 1) ))
		return
	if ((src.density && (stat & NOPOWER) && !( src.operating )))
		spawn( 0 )
			src.operating = 1
			flick("pdoorc0", src)
			src.icon_state = "pdoor0"
			src.setOpac(0)
			sleep(15)
			src.setDensity(0)
			src.operating = 0
			return
	return


/obj/machinery/door/poddoor/salus/multi_tile/three_one_poddoor/open()
	if (src.operating == 1) //doors can still open when emag-disabled
		return
	if (!ticker)
		return 0
	if(!src.operating) //in case of emag
		src.operating = 1
	flick("pdoorc0", src)
	src.icon_state = "pdoor0"
	src.setOpac(0)
	sleep(10)
	layer = initial(layer)
	src.setDensity(0)
	update_nearby_tiles()

	if(operating == 1) //emag again
		src.operating = 0
	if(autoclose)
		spawn(150)
			autoclose()
	return 1

/obj/machinery/door/poddoor/salus/multi_tile/three_one_poddoor/close()
	if (src.operating)
		return
	src.operating = 1
	layer = 3.3
	flick("pdoorc1", src)
	src.icon_state = "pdoor1"
	src.setDensity(1)
	src.setOpac(initial(opacity))
	update_nearby_tiles()

	sleep(10)
	src.operating = 0
	return