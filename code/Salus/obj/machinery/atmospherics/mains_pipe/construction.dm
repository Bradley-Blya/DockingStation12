/*CONTENTS
Buildable pipes
Buildable meters
*/
#define MAINS_PIPE_SIMPLE_STRAIGHT 	0
#define MAINS_PIPE_SIMPLE_BENT		1
#define MAINS_PIPE_CAP				2
#define MAINS_PIPE_MANIFOLD			3
#define MAINS_PIPE_MANIFOLD4W		4
#define MAINS_PIPE_SPLIT			5
#define MAINS_PIPE_SPLIT_AUX		6
#define MAINS_PIPE_SPLIT_SCRUBBERS	7
#define MAINS_PIPE_SPLIT_SUPPLY		8
#define MAINS_PIPE_SPLIT3W			9	//All three pipes are split instead of just a single one

#define MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT 	10
#define MAINS_GENERAL_PIPE_SIMPLE_BENT		11
#define MAINS_GENERAL_PIPE_CAP				12
#define MAINS_GENERAL_PIPE_MANIFOLD			13
#define MAINS_GENERAL_PIPE_MANIFOLD4W		14
#define MAINS_GENERAL_PIPE_SPLIT			15
#define MAINS_GENERAL_PIPE_SPLIT_SCRUBBERS	16
#define MAINS_GENERAL_PIPE_SPLIT_SUPPLY		17
#define MAINS_GENERAL_PIPE_SPLIT3W			18	//Both pipes are split instead of one. Called 3W for ease of copy-paste. Lazy, k?

/*
#define MAINS_PIPE_MVALVE			8
#define MAINS_PIPE_MTVALVE			18
#define MAINS_PIPE_MANIFOLD4W		19*/

/obj/item/mains_pipe
	name = "mains pipe"
	desc = "A mains pipe"
	var/pipe_type = 0
	var/pipe_split_type = 0		//0 = none; 1 = Scrubbers; 2 = Aux; 3 = Supply
	//var/pipe_dir = 0
	var/pipename
	force = 7
	icon = 'icons/obj/atmospherics/mainspipe.dmi'
	icon_state = "intact"
//	item_state = "buildpipe"
	flags = TABLEPASS|FPRINT
	w_class = 3
	level = 2

/obj/item/mains_pipe/New(var/loc, var/pipe_type as num, var/dir as num, var/obj/machinery/atmospherics/mains_pipe/make_from = null)
	..()
	if (make_from)
		//Set the correct icon file for the object if it's the general pipe
		if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general))
			icon = 'icons/salus/obj/atmospherics/mainspipe_test.dmi'
	//	world << "loc: [loc]. pipe_type: [pipe_type]. dir: [dir]. pipe_split_type: [ pipe_split_type]. make_from: [make_from]."
		src.dir = make_from.dir
		src.pipename = make_from.name
		color = make_from.color
		var/is_bent
		if  (make_from.initialize_mains_directions in list(NORTH|SOUTH, WEST|EAST))
			is_bent = 0
		else
			is_bent = 1
		//Mains Pipes
		if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/simple))
			src.pipe_type = MAINS_PIPE_SIMPLE_STRAIGHT + is_bent
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/manifold))
			src.pipe_type = MAINS_PIPE_MANIFOLD
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/manifold4w))
			src.pipe_type = MAINS_PIPE_MANIFOLD4W
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/cap))
			src.pipe_type = MAINS_PIPE_CAP
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/split))
			src.pipe_type = MAINS_PIPE_SPLIT
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/split/aux))
			src.pipe_type = MAINS_PIPE_SPLIT_AUX
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/split/scrubbers))
			src.pipe_type = MAINS_PIPE_SPLIT_SCRUBBERS
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/split/supply))
			src.pipe_type = MAINS_PIPE_SPLIT_SUPPLY
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/split3))
			src.pipe_type = MAINS_PIPE_SPLIT3W
		//General Mains Pipes (Only has a scrubbers and a supply Pipe)
		if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/simple))
			src.pipe_type = MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT + is_bent
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/manifold))
			src.pipe_type = MAINS_GENERAL_PIPE_MANIFOLD
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/manifold4w))
			src.pipe_type = MAINS_GENERAL_PIPE_MANIFOLD4W
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/cap))
			src.pipe_type = MAINS_GENERAL_PIPE_CAP
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/split))
			src.pipe_type = MAINS_GENERAL_PIPE_SPLIT
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/split/scrubbers))
			src.pipe_type = MAINS_GENERAL_PIPE_SPLIT_SCRUBBERS
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/split/supply))
			src.pipe_type = MAINS_GENERAL_PIPE_SPLIT_SUPPLY
		else if(istype(make_from, /obj/machinery/atmospherics/mains_pipe/salus/general/split3))
			src.pipe_type = MAINS_GENERAL_PIPE_SPLIT3W
	else
		src.pipe_type = pipe_type
		src.dir = dir

		if(src.pipe_type in list( MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT, MAINS_GENERAL_PIPE_MANIFOLD, MAINS_GENERAL_PIPE_MANIFOLD4W, MAINS_GENERAL_PIPE_CAP, MAINS_GENERAL_PIPE_SPLIT, MAINS_GENERAL_PIPE_SPLIT_SCRUBBERS, MAINS_GENERAL_PIPE_SPLIT_SUPPLY, MAINS_GENERAL_PIPE_SPLIT3W))
			icon = 'icons/salus/obj/atmospherics/mainspipe_test.dmi'
	//src.pipe_dir = get_pipe_dir()
//	world << "loc: [loc]. pipe_type: [pipe_type]. dir: [dir]. pipe_split_type: [ pipe_split_type]. make_from: [make_from]."
	update()
	src.pixel_x = rand(-5, 5)
	src.pixel_y = rand(-5, 5)

//update the name and icon of the pipe item depending on the type

/obj/item/mains_pipe/proc/update()
	var/list/nlist = list( \
		"pipe", \
		"bent pipe", \
		"pipe cap", \
		"manifold", \
		"4-way manifold", \
		"split pipe", \
		"split pipe(aux)", \
		"split pipe(scrubbers)", \
		"split pipe(supply)", \
		"split pipe",\
		//general mains pipes
		"pipe", \
		"bent pipe", \
		"pipe cap", \
		"manifold", \
		"4-way manifold", \
		"split pipe", \
		"split pipe(scrubbers)", \
		"split pipe(supply)", \
		"split pipe"
	)
	name = nlist[pipe_type+1] + " fitting"
	var/list/islist = list( \
		"intact", \
		"intact", \
		"cap", \
		"manifold", \
		"manifold4w", \
		"intact", \
		"split-aux", \
		"split-scrubbers", \
		"split-supply", \
		"split-t", \
		"intact", \
		"intact", \
		"cap", \
		"manifold", \
		"manifold4w", \
		"intact", \
		"split-scrubbers", \
		"split-supply", \
		"split-t"
	)
	icon_state = islist[pipe_type + 1]

//called when a turf is attacked with a pipe item
// place the pipe on the turf, setting pipe level to 1 (underfloor) if the turf is not intact

// rotate the pipe item clockwise

/obj/item/mains_pipe/verb/rotate()
	set category = "Object"
	set name = "Rotate Pipe"
	set src in view(1)

	if ( usr.stat || usr.restrained() )
		return

	src.dir = turn(src.dir, -90)

	if (pipe_type in list (MAINS_PIPE_SIMPLE_STRAIGHT/*PIPE_HE_STRAIGHT, PIPE_INSULATED_STRAIGHT, MAINS_PIPE_MVALVE*/))
		if(dir==2)
			dir = 1
		else if(dir==8)
			dir = 4
	else if (pipe_type == MAINS_PIPE_MANIFOLD4W)
		dir = 2
	//src.pipe_dir = get_pipe_dir()
	return

/obj/item/mains_pipe/Move()
	..()
	if ((pipe_type in list (MAINS_PIPE_SIMPLE_BENT)) \
		&& (src.dir in cardinal))
		src.dir = src.dir|turn(src.dir, 90)
	else if (pipe_type in list (MAINS_PIPE_SIMPLE_STRAIGHT))
		if(dir==2)
			dir = 1
		else if(dir==8)
			dir = 4
	return

// returns all pipe's endpoints

/obj/item/mains_pipe/proc/get_pipe_dir()
	if (!dir)
		return 0
	var/flip = turn(dir, 180)
	var/cw = turn(dir, -90)
	var/acw = turn(dir, 90)

	switch(pipe_type)
		//Standard Mains Pipes
		if(MAINS_PIPE_SIMPLE_STRAIGHT)
			return dir|flip
		if(MAINS_PIPE_SIMPLE_BENT)
			return dir //dir|acw
		if(MAINS_PIPE_MANIFOLD4W)
			return dir|flip|cw|acw
		if(MAINS_PIPE_MANIFOLD)
			return flip|cw|acw
		if(MAINS_PIPE_CAP)
			return flip
		if(MAINS_PIPE_SPLIT_AUX)
			return dir|flip
		if(MAINS_PIPE_SPLIT_SCRUBBERS)
			return dir|flip
		if(MAINS_PIPE_SPLIT_SUPPLY)
			return dir|flip
		if(MAINS_PIPE_SPLIT3W)
			return flip
		//General Mains Pipes
		if(MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT)
			return dir|flip
		if(MAINS_GENERAL_PIPE_SIMPLE_BENT)
			return dir //dir|acw
		if(MAINS_GENERAL_PIPE_MANIFOLD4W)
			return dir|flip|cw|acw
		if(MAINS_GENERAL_PIPE_MANIFOLD)
			return flip|cw|acw
		if(MAINS_GENERAL_PIPE_CAP)
			return flip
		if(MAINS_GENERAL_PIPE_SPLIT_SCRUBBERS)
			return dir|flip
		if(MAINS_GENERAL_PIPE_SPLIT_SUPPLY)
			return dir|flip
		if(MAINS_GENERAL_PIPE_SPLIT3W)
			return flip
	return 0

//Not sure if it's actually used, but best to have it here incase it's called.
/obj/item/mains_pipe/proc/get_pdir() //endpoints for regular pipes
	return get_pipe_dir()

/obj/item/mains_pipe/attack_self(mob/user as mob)
	return rotate()

/obj/item/mains_pipe/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	..()

	if (!istype(W, /obj/item/weapon/wrench))
		return ..()
	if (!isturf(src.loc))
		return 1
	if (pipe_type in list (MAINS_PIPE_SIMPLE_STRAIGHT, MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT))	//Make the pipe face one of the 4 directions if the pipe is straight.
		if(dir==2)
			dir = 1
		else if(dir==8)
			dir = 4
	else if (pipe_type in list(MAINS_PIPE_MANIFOLD4W, MAINS_GENERAL_PIPE_MANIFOLD4W))
		dir = 2

	var/pipe_dir = get_pipe_dir()

	for(var/obj/machinery/atmospherics/M in src.loc)
		if(M.initialize_directions & pipe_dir)	// matches at least one direction on either type of pipe
			user << "\red There is already a pipe at that location."
			return 1
	// no conflicts found

	var/pipefailtext = "\red There's nothing to connect this pipe section to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"

	switch(pipe_type)
		//Standard Mains Pipes
		if(MAINS_PIPE_SIMPLE_STRAIGHT, MAINS_PIPE_SIMPLE_BENT)
			var/obj/machinery/atmospherics/mains_pipe/simple/P = new( src.loc )
			P.color = color
			P.dir = src.dir
			P.initialize_mains_directions = pipe_dir
			var/turf/T = P.loc
			P.level = T.intact ? 2 : 1
			P.initialize()
			if (!P)
				usr << pipefailtext
				return 1
			P.build_network()

		if(MAINS_PIPE_MANIFOLD)		//manifold
			var/obj/machinery/atmospherics/mains_pipe/manifold/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_PIPE_MANIFOLD4W)		//4-way manifold
			var/obj/machinery/atmospherics/mains_pipe/manifold4w/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_PIPE_SPLIT_AUX)
			var/obj/machinery/atmospherics/mains_pipe/split/aux/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_PIPE_SPLIT_SCRUBBERS)
			var/obj/machinery/atmospherics/mains_pipe/split/scrubbers/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_PIPE_SPLIT_SUPPLY)
			var/obj/machinery/atmospherics/mains_pipe/split/supply/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_PIPE_SPLIT3W)
			var/obj/machinery/atmospherics/mains_pipe/split3/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_PIPE_CAP)
			var/obj/machinery/atmospherics/mains_pipe/cap/C = new(src.loc)
			C.dir = dir
			C.initialize_mains_directions = pipe_dir
			C.initialize()
			C.build_network()

		//General Mains Pipes
		if(MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT, MAINS_GENERAL_PIPE_SIMPLE_BENT)
			var/obj/machinery/atmospherics/mains_pipe/salus/general/simple/P = new( src.loc )
			P.color = color
			P.dir = src.dir
			P.initialize_mains_directions = pipe_dir
			var/turf/T = P.loc
			P.level = T.intact ? 2 : 1
			P.initialize()
			if (!P)
				usr << pipefailtext
				return 1
			P.build_network()
			if(P.contents)
				for(var/obj/machinery/atmospherics/pipe/mains_component/A in P.contents)
					A.initialize()
					A.build_network()
					for(var/obj/machinery/atmospherics/pipe/mains_component/B in A.nodes)
						B.initialize()
						B.build_network()

		if(MAINS_GENERAL_PIPE_MANIFOLD)		//manifold
			var/obj/machinery/atmospherics/mains_pipe/salus/general/manifold/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_GENERAL_PIPE_MANIFOLD4W)		//4-way manifold
			var/obj/machinery/atmospherics/mains_pipe/salus/general/manifold4w/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_GENERAL_PIPE_SPLIT_SCRUBBERS)
			var/obj/machinery/atmospherics/mains_pipe/salus/general/split/scrubbers/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_GENERAL_PIPE_SPLIT_SUPPLY)
			var/obj/machinery/atmospherics/mains_pipe/salus/general/split/supply/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_GENERAL_PIPE_SPLIT3W)
			var/obj/machinery/atmospherics/mains_pipe/salus/general/split3/M = new( src.loc )
			M.color = color
			M.dir = dir
			M.initialize_mains_directions = pipe_dir
			//M.New()
			var/turf/T = M.loc
			M.level = T.intact ? 2 : 1
			M.initialize()
			if (!M)
				usr << "There's nothing to connect this manifold to! (with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"
				return 1
			M.build_network()

		if(MAINS_GENERAL_PIPE_CAP)
			var/obj/machinery/atmospherics/mains_pipe/salus/general/cap/C = new(src.loc)
			C.dir = dir
			C.initialize_mains_directions = pipe_dir
			C.initialize()
			C.build_network()

	playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
	user.visible_message( \
		"[user] fastens the [src].", \
		"\blue You have fastened the [src].", \
		"You hear ratchet.")
	del(src)	// remove the pipe item

	return
	 //TODO: DEFERRED

// ensure that setterm() is called for a newly connected pipeline


/*
/obj/item/pipe_meter
	name = "meter"
	desc = "A meter that can be laid on pipes"
	icon = 'icons/obj/pipe-item.dmi'
	icon_state = "meter"
	item_state = "buildpipe"
	flags = TABLEPASS|FPRINT
	w_class = 4

/obj/item/pipe_meter/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	..()

	if (!istype(W, /obj/item/weapon/wrench))
		return ..()
	if(!locate(/obj/machinery/atmospherics/pipe, src.loc))
		user << "\red You need to fasten it to a pipe"
		return 1
	new/obj/machinery/meter( src.loc )
	playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
	user << "\blue You have fastened the meter to the pipe"
	del(src)
*/
//not sure why these are necessary //Because definitions are important! Otherwise their, they're, and there would have the same meaning.
#undef MAINS_PIPE_SIMPLE_STRAIGHT
#undef MAINS_PIPE_SIMPLE_BENT
#undef MAINS_PIPE_CAP
#undef MAINS_PIPE_MANIFOLD
#undef MAINS_PIPE_MANIFOLD4W
#undef MAINS_PIPE_SPLIT
#undef MAINS_PIPE_SPLIT_AUX
#undef MAINS_PIPE_SPLIT_SCRUBBERS
#undef MAINS_PIPE_SPLIT_SUPPLY
#undef MAINS_PIPE_SPLIT3W				//All three pipes are split instead of just a single one

#undef MAINS_GENERAL_PIPE_SIMPLE_STRAIGHT
#undef MAINS_GENERAL_PIPE_SIMPLE_BENT
#undef MAINS_GENERAL_PIPE_CAP
#undef MAINS_GENERAL_PIPE_MANIFOLD
#undef MAINS_GENERAL_PIPE_MANIFOLD4W
#undef MAINS_GENERAL_PIPE_SPLIT
#undef MAINS_GENERAL_PIPE_SPLIT_SCRUBBERS
#undef MAINS_GENERAL_PIPE_SPLIT_SUPPLY
#undef MAINS_GENERAL_PIPE_SPLIT3W
