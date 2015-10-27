/obj/machinery/door/poddoor/salus/multi_tile
//	dir = 1
//	explosion_resistance = 75					//Has 5 times as must explosion resistance because it's twice as large as a regular poddoor.
//	width = 3
	var/list/filler_objects = list()
	var/obj/machinery/door/poddoor/filler_object/f1
	var/obj/machinery/door/poddoor/filler_object/f2
	var/obj/machinery/door/poddoor/filler_object/f3
	var/obj/machinery/door/poddoor/filler_object/f4
	var/obj/machinery/door/poddoor/filler_object/f5

/obj/machinery/door/poddoor/filler_object
	name = ""
	icon_state = ""
	var/owner


/obj/machinery/door/poddoor/filler_object/Bumped(atom/AM)
	if(!density)
		return ..()
	else
		return 0

/obj/machinery/door/firedoor/salus/multi_tile
//	dir = 1
//	explosion_resistance = 75					//Has 5 times as must explosion resistance because it's twice as large as a regular poddoor.
//	width = 3
	var/list/filler_objects = list()
	var/obj/machinery/door/filler_object/f1
	var/obj/machinery/door/filler_object/f2
	var/obj/machinery/door/filler_object/f3
	var/obj/machinery/door/filler_object/f4
	var/obj/machinery/door/filler_object/f5


/obj/machinery/door/filler_object
	name = ""
	icon_state = ""
	var/owner


/obj/machinery/door/filler_object/Bumped(atom/AM)
	if(!density)
		return ..()
	else
		return 0