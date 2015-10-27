/obj/machinery/door/poddoor/salus/multi_tile/proc/setDensity(var/S)

	src.density = S
	for(var/obj/machinery/door/filler_object/F in src.filler_objects)
		F.density = S
	return

/obj/machinery/door/poddoor/salus/multi_tile/proc/setOpac(var/S)

	src.SetOpacity(S)
	for(var/obj/machinery/door/filler_object/F in src.filler_objects)
		F.SetOpacity(S)
	return


/obj/machinery/door/poddoor/salus/multi_tile/proc/spawn_filler_objects(var/S)

//	world << "[src]"

	var/i = 0

	for(var/turf/simulated/T in locs)
		if(T.has_filler_object)	continue
		switch(i)
			if(0)
				src.f1 = new /obj/machinery/door/filler_object(T.loc)
				src.f1.owner = src
				src.filler_objects += src.f1
				T.contents += f1
			if(1)
				src.f2 = new /obj/machinery/door/filler_object(T.loc)
				src.f2.owner = src
				src.filler_objects += src.f2
				T.contents += f2
			if(2)
				src.f3 = new /obj/machinery/door/filler_object(T.loc)
				src.f3.owner = src
				src.filler_objects += src.f3
				T.contents += f3
			if(3)
				src.f4 = new /obj/machinery/door/filler_object(T.loc)
				src.f4.owner = src
				src.filler_objects += src.f4
				T.contents += f4
			if(4)
				src.f5 = new /obj/machinery/door/filler_object(T.loc)
				src.f5.owner = src
				src.filler_objects += src.f5
				T.contents += f5
		i++
		T.has_filler_object = 1
//		world << "Break 5"

	return




/obj/machinery/door/firedoor/salus/multi_tile/proc/setDensity(var/S)

	src.density = S
	for(var/obj/machinery/door/filler_object/F in src.filler_objects)
		F.density = S
	return

/obj/machinery/door/firedoor/salus/multi_tile/proc/setOpac(var/S)

	src.SetOpacity(S)
	for(var/obj/machinery/door/filler_object/F in src.filler_objects)
		F.SetOpacity(S)
	return


/obj/machinery/door/firedoor/salus/multi_tile/proc/spawn_filler_objects(var/S)

//	world << "[src]"

	var/i = 0

	for(var/turf/simulated/T in locs)
		if(T.has_filler_object)	continue
		switch(i)
			if(0)
				src.f1 = new /obj/machinery/door/filler_object(T.loc)
				src.f1.owner = src
				src.filler_objects += src.f1
				T.contents += f1
			if(1)
				src.f2 = new /obj/machinery/door/filler_object(T.loc)
				src.f2.owner = src
				src.filler_objects += src.f2
				T.contents += f2
			if(2)
				src.f3 = new /obj/machinery/door/filler_object(T.loc)
				src.f3.owner = src
				src.filler_objects += src.f3
				T.contents += f3
			if(3)
				src.f4 = new /obj/machinery/door/filler_object(T.loc)
				src.f4.owner = src
				src.filler_objects += src.f4
				T.contents += f4
			if(4)
				src.f5 = new /obj/machinery/door/filler_object(T.loc)
				src.f5.owner = src
				src.filler_objects += src.f5
				T.contents += f5
		i++
		T.has_filler_object = 1
//		world << "Break 5"

	return

