/obj/machinery/computer3/salus/builderdrone
	default_prog = /datum/file/program/builderdrone


//Place-holder for the actual program

/datum/file/program/builderdrone
	name 		= "BuilDrone Control"
	desc 		= "Controller for a BuilDrone Unit."
	active_state = "cameras"
	image			= 'icons/ntos/program.png'

	var/linked_drone = null


	interact()
		usr.set_machine(src)
		if(!interactable())
			return
		var/dat = ""
		dat += "<center><span style='font-size:24pt'><b>Welcome to NTOS</b></span></center>"
		dat += "<center><span style='font-size:8pt'>Thank you for choosing NTOS, your gateway to the future of mobile computing technology, sponsored by Nanotrasen (R)</span></center><br>"
		dat += "<span style='font-size:12pt'><b>Getting started with NTOS:</b></span><br>"
		dat += "To leave a current program, click the X button in the top right corner of the window. This will return you to the NTOS desktop. \
		From the desktop, you can open the hard drive, usually located in the top left corner to access all the programs installed on your computer. \
		When you rented your laptop, you were supplied with programs that your Nanotrasen Issued ID has given you access to use. \
		In the event of a serious error, the right click menu will give you the ability to reset your computer. To open and close your laptop, alt-click your device.\
		 If you have any questions or technical issues, please contact your local computer technical experts at your local Central Command."
		popup.set_content(dat)
		popup.set_title_image(usr.browse_rsc_icon(computer.icon, computer.icon_state))
		popup.open()
		return

	Topic(href, href_list)
		if(!interactable() || ..(href,href_list))
			return
		interact()
		return


//Place-holder for actual object

/obj/machinery/salus/builderdrone
	name = "BuilDrone Unit"
	desc = "A standard NT Construction Drone equipped with a subspace networking card, self-replenishing power source, and Bluespace material storage unit."
	icon = 'icons/mob/custom-synthetic.dmi'
	icon_state = "ravensdale-Engineering"

	var/linked_console = null			//With this, there can be multiple builder drones at once
	var/linked_human = null				//I plan on implementing a type of oculus rift for use with this drone
	var/list/linked_sub_drones = list()
	var/obj/structure/cable/last_piece	//For more easily laying down cables properly
	var/obj/machinery/camera/C			//The camera for when a player wants to see what they're doing with the drone

	proc/reset()
		last_piece = null

/obj/machinery/salus/builderdrone/New()
	..()

/obj/machinery/salus/builderdrone/Del()
	linked_console = null
	linked_human = null
	..()

/obj/machinery/salus/builderdrone/proc/boot_up(mob/user as mob)
	user << "BuilDrone Unit T35T running startup procedures."
	linked_human = user
	if(linked_human && linked_human == user)
		user << "Successfully linked to master controller."
	else
		user << "Unable to establish Connection with master controller. BuilDrone Unit T35T powering off."
		return


/obj/machinery/salus/builderdrone/const_mat
	//place holder for interactions between the drone and the enviornment in regard to building
	name = "Construction Materials"


/obj/machinery/salus/builderdrone/proc/build_floor(var/turf/T)
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, T)
	if(L)
		T.RemoveLattice()
		T.ChangeTurf(/turf/simulated/floor/plating/airless)
		return 1
	else
		return 0

/obj/machinery/salus/builderdrone/proc/build_wall(var/turf/T)
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, T)
	var/turf/simulated/floor/plating/P = locate(/turf/simulated/floor/plating, T)
	if(L)
		T.RemoveLattice()
		T.ChangeTurf(/turf/simulated/wall)
		return 1
	else if(P)
		T.ChangeTurf(/turf/simulated/wall)
		return 1
	else
		return 0

/obj/machinery/salus/builderdrone/proc/make_space(var/turf/T)
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, T)
	var/turf/simulated/floor/plating/P = locate(/turf/simulated/floor/plating, T)
	var/turf/simulated/wall/W = locate(/turf/simulated/wall, T)
	if(L)
		T.RemoveLattice()
		T.ChangeTurf(/turf/space)
		return 1
	else if(P)
		T.ChangeTurf(/turf/space)
		return 1
	else if(W)
		T.ChangeTurf(/turf/space)
		return 1
	else
		return 0

/obj/machinery/salus/builderdrone/proc/make_cable(var/turf/T1, var/turf/T2, var/turf/T3, var/turf/T4)		//T3 and T4 are optional. They are only if the cable needs to be made into a corner
//	var/idir = get_dir(T1,T2)
//	var/dist = get_dist(T1,T2)


/obj/machinery/salus/builderdrone/proc/experiemental_new_cable(var/turf/new_turf)
	var/fdirn = turn(src.dir, 180)
	for(var/obj/structure/cable/LC in new_turf)		// check to make sure there's not a cable there already
		if(LC.d1 == fdirn || LC.d2 == fdirn)
			return reset()
	var/obj/structure/cable/NC = new(new_turf)
	NC.cableColor("red")
	NC.d1 = 0
	NC.d2 = fdirn
	NC.updateicon()

	var/datum/powernet/PN
	if(last_piece && last_piece.d2 != src.dir)
		last_piece.d1 = min(last_piece.d2, src.dir)
		last_piece.d2 = max(last_piece.d2, src.dir)
		last_piece.updateicon()
		PN = last_piece.powernet

	if(!PN)
		PN = new()
		powernets += PN
	NC.powernet = PN
	PN.cables += NC
	NC.mergeConnectedNetworks(NC.d2)

	last_piece = NC
	return 1


/obj/machinery/salus/builderdrone/proc/new_cable(var/turf/T1, var/turf/T2)	//Need 2 turfs so that it knows how to orient the cable
	var/cable_dir1 = get_dir(T1,T2)
//	var/cable_dir2 = turn(cable_dir1, 180)		//The opposite direction
//	var/cable_dist = get_dist(T1,T2)
	var/current_turf = T1
//	var/obj/structure/cable/new_cable

//	new_cable = new /obj/structure/cable(current_turf)
//	new_cable.d2 = cable_dir2

	//I'll just have copy and paste the code from the /obj/item/cable_coil to get this to work
//	for(var/i = 0; i >= (cable_dist - 2) ; i++)
	/*	current_turf = get_step(current_turf,cable_dir)
		new_cable = new /obj/structure/cable(current_turf)
		new_cable.d1 = cable_dir1
		new_cable.d2 = cable_dir2*/

		//Begin of copy-paste
	for(var/obj/structure/cable/LC in current_turf)
		if((LC.d1 == cable_dir1 && LC.d2 == 0 ) || ( LC.d2 == cable_dir1 && LC.d1 == 0))
//				user << "<span class='warning'>There's already a cable at that position.</span>"
			return
///// Z-Level Stuff
		// check if the target is open space
	if(istype(current_turf, /turf/simulated/floor/open))
		for(var/obj/structure/cable/LC in current_turf)
			if((LC.d1 == cable_dir1 && LC.d2 == 11 ) || ( LC.d2 == cable_dir1 && LC.d1 == 11))
//					user << "<span class='warning'>There's already a cable at that position.</span>"
				return

		var/turf/simulated/floor/open/temp = current_turf
		var/obj/structure/cable/C = new(current_turf)
		var/obj/structure/cable/D = new(temp.floorbelow)

//			C.cableColor(item_color)

		C.d1 = 11
		C.d2 = cable_dir1
//			C.add_fingerprint(user)
		C.updateicon()

		C.powernet = new()
		powernets += C.powernet
		C.powernet.cables += C

		C.mergeConnectedNetworks(C.d2)
		C.mergeConnectedNetworksOnTurf()

//			D.cableColor(item_color)

		D.d1 = 12
		D.d2 = 0
//		D.add_fingerprint(user)
		D.updateicon()

		D.powernet = C.powernet
		D.powernet.cables += D

		D.mergeConnectedNetworksOnTurf()

		// do the normal stuff
	else
///// Z-Level Stuff

		for(var/obj/structure/cable/LC in current_turf)
			if((LC.d1 == cable_dir1 && LC.d2 == 0 ) || ( LC.d2 == cable_dir1 && LC.d1 == 0))
//					user << "There's already a cable at that position."
				return

		var/obj/structure/cable/C = new(current_turf)

//			C.cableColor(item_color)

		C.d1 = 0
		C.d2 = cable_dir1
//			C.add_fingerprint(user)
		C.updateicon()

		C.powernet = new()
		powernets += C.powernet
		C.powernet.cables += C

		C.mergeConnectedNetworks(C.d2)
		C.mergeConnectedNetworksOnTurf()


//			use(1)
//			if (C.shock(user, 50))
//				if (prob(50)) //fail
//					new/obj/item/weapon/cable_coil(C.loc, 1, C.color)
//					del(C)
			//End of Copy-Paste

/obj/machinery/salus/builderdrone/proc/join_cables(obj/structure/cable/C, var/obj/machinery/salus/builderdrone/drone)
	//Begin copy-paste
	var/turf/U = drone.loc
	if(!isturf(U))
		return

	var/turf/T = C.loc

	if(!isturf(T) || T.intact)		// sanity checks, also stop use interacting with T-scanner revealed cable
		return

	if(get_dist(C, drone) > 1)		// make sure it's close enough
//		user << "<span class='warning'>You can't lay cable at a place that far away.</span>"
		return


	if(U == T)		// do nothing if we clicked a cable we're standing on
		return		// may change later if can think of something logical to do

	var/dirn = get_dir(C, drone)

	if(C.d1 == dirn || C.d2 == dirn)		// one end of the clicked cable is pointing towards us
		if(U.intact)						// can't place a cable if the floor is complete
//			user << "<span class='warning'>You can't lay cable there unless the floor tiles are removed.</span>"
			return
		else
			// cable is pointing at us, we're standing on an open tile
			// so create a stub pointing at the clicked cable on our tile

			var/fdirn = turn(dirn, 180)		// the opposite direction

			for(var/obj/structure/cable/LC in U)		// check to make sure there's not a cable there already
				if(LC.d1 == fdirn || LC.d2 == fdirn)
//					user << "<span class='warning'>There's already a cable at that position.</span>"
					return

			var/obj/structure/cable/NC = new(U)
//			NC.cableColor(item_color)

			NC.d1 = 0
			NC.d2 = fdirn
//			NC.add_fingerprint()
			NC.updateicon()

			if(C.powernet)
				NC.powernet = C.powernet
				NC.powernet.cables += NC
				NC.mergeConnectedNetworks(NC.d2)
				NC.mergeConnectedNetworksOnTurf()
//			use(1)
//			if (NC.shock(user, 50))
//				if (prob(50)) //fail
//					new/obj/item/weapon/cable_coil(NC.loc, 1, NC.color)
//					del(NC)

			return
	else if(C.d1 == 0)		// exisiting cable doesn't point at our position, so see if it's a stub
							// if so, make it a full cable pointing from it's old direction to our dirn
		var/nd1 = C.d2	// these will be the new directions
		var/nd2 = dirn


		if(nd1 > nd2)		// swap directions to match icons/states
			nd1 = dirn
			nd2 = C.d2


		for(var/obj/structure/cable/LC in T)		// check to make sure there's no matching cable
			if(LC == C)			// skip the cable we're interacting with
				continue
			if((LC.d1 == nd1 && LC.d2 == nd2) || (LC.d1 == nd2 && LC.d2 == nd1) )	// make sure no cable matches either direction
//				user << "<span class='warning'>There's already a cable at that position.</span>"
				return


//		C.cableColor(item_color)

		C.d1 = nd1
		C.d2 = nd2

//		C.add_fingerprint()
		C.updateicon()


		C.mergeConnectedNetworks(C.d1)
		C.mergeConnectedNetworks(C.d2)
		C.mergeConnectedNetworksOnTurf()

//		use(1)
//		if (C.shock(user, 50))
//			if (prob(50)) //fail
//				new/obj/item/weapon/cable_coil(C.loc, 2, C.color)
//				del(C)

		return
	//End copy-paste

/obj/machinery/salus/builderdrone/slave
	var/master_drone

/obj/machinery/salus/builderdrone/slave/cabledrone
	name = "C4BL3 Drone"
	desc = "An NT Construction drone fitted with the singular duty of laying cable. What a life, eh?"
	icon_state = "pear120-Engineering"

/obj/machinery/salus/builderdrone/slave/installdrone
	name = "IN57411 Drone"
	desc = "An NT Construction drone that is equipped with various tools to install and secure anything the BuilDrone Unit places."
	icon_state = "pandarsenic-Engineering"




