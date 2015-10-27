/client/proc/aknockout(mob/living/carbon/human/M as mob in mob_list)
	set category = "Admin"
	set desc = "Sets the Character's paralysis to 10000. ONLY USE WHEN DEALING WITH GRIEFERS." //Might end up changing the paralysis value
	set name = "Admin Knockout"

	if(M.paralysis < 1000)
	//	world << "Line 468: randomverbs.dm Reached in Code" //Testing Code
		M.SetParalysis(100000)
		M.canmove = 0
		M.blinded = 1
		M << "<font size=3>You are suspected of breaking the rules/griefing and have been temporarily Paralyzed. An Admin will contact you momentarily."
		M << 'sound/effects/-adminhelp.ogg'
		log_admin("[key_name(usr)] used Admin Knockout on [key_name(M)]")
		message_admins("\blue [key_name_admin(usr)] used Admin Knockout on [key_name(M)].", 1)
	else if(M.paralysis > 1000)
	//	world << "Line 479: randomverbs.dm Reached in Code" //Testing Code
		M.SetParalysis(0)
		M.canmove = 1
		M.blinded = 0
		log_admin("[key_name(usr)] reset Admin Knockout on [key_name(M)]")
		message_admins("\blue [key_name_admin(usr)] reset Admin Knockout on [key_name(M)].", 1)
	feedback_add_details("admin_verb","AKO")


//This is the current code for the station's Atmosphere Reset Admin Command.
//Needs to reset any air alarms and fire alarms as well, as this command can cause issues that cannot be fixed if there is severe atmos grief.

/client/proc/asatmosreset()
	set category = "Admin"
	set desc = "Resets the /Entire/ Station's Atmosphere. Only for use with extreme Atmos Grief."
	set name = "Admin Station Atmos Reset"

	log_admin("[key_name(usr)] reset the Station's Atmos!")
	message_admins("\blue [key_name_admin(usr)] reset the Station's Atmos!", 1)
	for(var/area/A in station_areas)
//		world << "[A.name]:[A]"
		for(var/turf/simulated/T in A.contents)
			if(T.contents)
				for(var/obj/machinery/atmospherics/pipe/x in T.contents)
					if(!isobj(x)) return
					if(x.parent.air)
						x.parent.air.reset()
				for(var/obj/fire/y in T.contents)
					if(!isobj(y)) return
					del(y)
			if(T.zone)
				T.zone.air.reset()
			else if(!T.zone && T.air)
				T.air.reset()
			if((istype(T.loc,/area/atmos))||(istype(T,/turf/simulated/floor/engine)))
				if(T.name == "n2 floor")
					T.zone.air.reset(0, 0, 100000, 0)
				else if(T.name == "o2 floor")
					T.zone.air.reset(100000,0,0,0)
				else if(T.name == "air floor")
					T.zone.air.reset(2000,0,8000,0)
				else if(T.name == "phoron floor")
					T.zone.air.reset(0,0,0,100000)
			continue
	resetAirAlarms()
	resetFireAlarms()
	feedback_add_details("admin_verb","ASAR")




/client/proc/aatmosreset(turf/simulated/T in world)
	set category = "Admin"
	set desc = "Resets individual area Atmospheres."
	set name = "Admin Zone Atmos Reset"

	if(T.zone)
		T.zone.air.reset()
	else if(!T.zone)
		T.air.reset()
	feedback_add_details("admin_verb","AAR")

// Unnecessary because of the removal of Telescience
/*
/client/proc/toggletelescience()
	set category = "Admin"
	set desc = "Toggles Telescience"
	set name = "Disable Telescience"

	var/announcedc = 0

	for(var/obj/machinery/computer/telescience/C in world)
		if(C.dtelescience)
			C.dtelescience = 0
			if(announcedc == 0)
				announcedc = 1
				log_admin("[key_name(usr)] has enabled Telescience!")
				message_admins("\blue [key_name_admin(usr)] has enabled Telescience!", 1)
		else
			C.dtelescience = 1
			if(announcedc == 0)
				announcedc = 1
				log_admin("[key_name(usr)] has disabled Telescience!")
				message_admins("\blue [key_name_admin(usr)] has disabled Telescience!", 1)
	announcedc = 0
*/


/proc/resetTurfPipeAtmos(/*var/turf/simulated/T,*/var/area/B)
	for(var/turf/simulated/T in B.contents)
		if(T.contents)
			for(var/obj/machinery/atmospherics/pipe/x in T.contents)
				if(!isobj(x)) return
				if(x.parent.air)
					x.parent.air.reset()
			for(var/obj/fire/y in T.contents)
				if(!isobj(y)) return
				del(y)
		if((istype(T.loc,/area/atmos))||(istype(T,/turf/simulated/floor)))
			if(T.zone)
				T.zone.air.reset()
		if((istype(T.loc,/area/atmos))||(istype(T,/turf/simulated/floor/engine)))
			if(T.name == "n2 floor")
				T.zone.air.reset(0, 0, 100000, 0)
			else if(T.name == "o2 floor")
				T.zone.air.reset(100000,0,0,0)
			else if(T.name == "air floor")
				T.zone.air.reset(2000,0,8000,0)
			else if(T.name == "phoron floor")
				T.zone.air.reset(0,0,0,100000)
		if(T.zone)
			T.zone.air.reset()
			break


/proc/resetAirAlarms()
/*	for(var/obj/machinery/firealarm/F in world)
		F.reset()*/
	for(var/obj/machinery/alarm/A in world)
		A.apply_danger_level(0)
//			world << "Set [A]'s danger level to 0"

		/*
		if(A.alarm_area)
			A.alarm_area.atmosalm = 0
		if(A.icon_state == "alarm1" || A.icon_state == "alarm2")
			A.icon_state = "alarm0"
			A.update_icon()*/

//Incredibly simply for an issue that has evaded resolution for so many months.

/proc/resetFireAlarms()
	for(var/obj/machinery/firealarm/A in world)
		A.reset()
//			world << "Reset fire alarm: [A]"

// As it says, only a test.

/client/proc/testserverrepop()
	set category = "Admin"
	set desc = "Testing the Repop() proc"
	set name = "Test Repop"

	world << "Repopulating World with Repop() !"
	world.Repop()

//Only meant for testing. I mean come on, why would you otherwise want to delete all of the objects in the world?
/client/proc/testserverrepopdelete()
	set category = "Admin"
	set desc = "Preparing the world for the testing of the Repop() proc"
	set name = "Test Repop: Delete"

	world << "Repreparing the world for a repopulation test!"
	for(var/obj/A in world )
		del(A)

// Putting this here so that it is easier to copy over, instead of having to find the actual code in an old version or something then having to find out where to put it in the new code
/datum/gas_mixture/proc/reset(a = MOLES_O2STANDARD, b = 0, c = MOLES_N2STANDARD, d = 0, list/datum/gas/traces = list())

	oxygen = a
	carbon_dioxide = b
	nitrogen = c
	phoron = d
	temperature = 293.15

	for(var/datum/gas/G in src.trace_gases)
	//	var/datum/gas/T = locate(G.type) in trace_gases
		if(G)
			del(G)
	update_values()
	return

/client/proc/cleanblood()
	set category = "Admin"
	set desc = "Used to delete all of the blood around the map to free up memory. Also deletes vomit."
	set name = "Admin Clean Blood and Vomit"

	log_admin("[key_name(usr)] cleaned up all of the vomit and blood around the Station!")
	for(var/obj/effect/decal/cleanable/X in world.contents)
		if(!istype(X,/obj/effect/decal/cleanable)) return
		del(X)


/*
	Make an Airlock in-game!
	To say that this is experimental is an understatement. Should just say it's non-functional.
	Will definitely need to rewrite this at some point.
*/

/*

/client/proc/admin_make_airlock(mob/user as mob)
	set category = "Admin"
	set desc = "Prompts the user to set a number of points, as well as specify some additional information, then constructs an airlock from that."
	set name = "Make Airlock (Experimental)"

	//Locations for the airlock's components

	var/controller_loc
	var/controller_type // 1 = Regular, 2 = Advanced
	var/chamber_sensor_loc
//	var/exterior_sensor_loc
//	var/interior_sensor_loc
	var/airpump_loc
	var/airpump_dir
	var/exterior_door_loc
	var/interior_door_loc
	var/exterior_button_loc
	var/interior_button_loc

	//Declaring the actual airlock components to be manipulated in this code

	var/obj/machinery/embedded_controller/radio/controller
	var/obj/machinery/atmospherics/unary/vent_pump/high_volume/airpump
	var/obj/machinery/airlock_sensor/chamber_sensor
	var/obj/machinery/door/airlock/exterior_door
	var/obj/machinery/door/airlock/interior_door
	var/obj/machinery/access_button/exterior_button
	var/obj/machinery/access_button/interior_button
//	var/obj/machinery/airlock_sensor/exterior_sensor
//	var/obj/machinery/airlock_sensor/interior_sensor

	//Additional variables to edit variables of the actual airlock components.
	//Mainly going to be used for adjusting the pixel offset before the spawning of the airlock components

/*	var/airlock_controller_p_offset_x
	var/airlock_controller_p_offset_y

	var/airlock_chamber_sensor_p_offset_x
	var/airlock_chamber_sensor_p_offset_y*/

	var/airlock_name
	var/objholder = /obj/machinery/door/airlock/external
	var/pixel_offset_type = 0 //Specified by player. 0 = none, 1 = manual, 2 = automatic

	airlock_name = ask_add_options("airlock_name")

	switch(alert("What should the airlock be called?",,"Custom Name","Use area name","Cancel"))
		if("Custom Name")
			airlock_name = input("What should the airlock be called?",,"airlock")
		if("Use area name")
			airlock_name = controller_loc:name
		if("Cancel")
			return

	//Begin with asking where the controller should go

	controller_loc = ask_ac_loc(user,"controller")

	//... And what type of controller it should be

	controller_type = ask_add_options("controller_type")

/*	switch(alert("What type of Airlock Controller should it be?",,"Regular","Advanced","Cancel"))
		if("Regular")
			controller_type = 1
		if("Advanced")
			controller_type = 2
		if("Cancel")
			return*/

	switch(alert("Want to specify additional arguements for pixel offset or let it automatically occur?",,"Yes","Automatic","No"))
		if("Yes")
			pixel_offset_type = 1
		if("Automatic")
			pixel_offset_type = 2
		if("No")
			return


	//Continue with the Chamber's sensor

	chamber_sensor_loc = ask_ac_loc(user,"chamber_sensor")

	//Then the airpump

	airpump_loc = ask_ac_loc(user,"airpump")

	//Inquire the airpump's desired direction

	switch(alert("What direction should the airpump face?",,"North","South","East","West"))
		if("North")
			airpump_dir = 1
		if("South")
			airpump_dir = 2
		if("East")
			airpump_dir = 4
		if("West")
			airpump_dir = 8
		else
			return

	//Now, where do the doors go?

	exterior_door_loc = ask_ac_loc(user,"exterior_door")

	interior_door_loc = ask_ac_loc(user,"interior_door")

	objholder = ask_add_options("airlock_type")

/*	switch(alert("What type of door should the airlocks be?",,"Standard","Non-Standard","Cancel"))
		if("Standard")
			objholder = /obj/machinery/door/airlock/external
		if("Non-Standard")
			objholder = text2path(input(usr,"Enter typepath:" ,"Typepath","/obj/machinery/door/airlock/external"))
			if(!ispath(objholder))
				objholder = /obj/machinery/door/airlock/external
				alert("That path is not allowed.")
			else
				if(ispath(objholder,/mob) && !check_rights(R_DEBUG,0))
					objholder = /obj/machinery/door/airlock/external
		if("Cancel")
			return*/


	//Only used if the airlock controller is advanced

//	if(controller_type == 2)

//		interior_sensor_loc = ask_ac_loc(user,"interior_sensor")
//		exterior_sensor_loc = ask_ac_loc(user,"exterior_sensor")

	//Specify where the buttons to open the airlock should go

	exterior_button_loc = get_step(exterior_door_loc,get_dir(interior_door_loc, exterior_door_loc))

	interior_button_loc = get_step(interior_door_loc,get_dir(exterior_door_loc, interior_door_loc))

	//Now begin spawning things.

	if(controller_type == 1)
		controller = new /obj/machinery/embedded_controller/radio/airlock_controller(controller_loc)

	if(controller_type == 2)
		controller = new /obj/machinery/embedded_controller/radio/advanced_airlock_controller(controller_loc)

	chamber_sensor = new /obj/machinery/airlock_sensor(chamber_sensor_loc)

	exterior_door = new objholder(exterior_door_loc)

	interior_door = new objholder(interior_door_loc)

	airpump = new /obj/machinery/atmospherics/unary/vent_pump/high_volume(airpump_loc)

	exterior_button = new /obj/machinery/access_button(exterior_button_loc)

	interior_button = new /obj/machinery/access_button(interior_button_loc)

/*	if(exterior_sensor_loc)
		exterior_sensor = new /obj/machinery/airlock_sensor(exterior_sensor_loc)

	if(interior_sensor_loc)
		interior_sensor = new /obj/machinery/airlock_sensor(interior_sensor_loc)
*/
	//Begin with setting up all of the variables

	//Airlock Controller tags

	controller.id_tag = "[airlock_name]_controller"

	controller.tag_exterior_door = "[airlock_name]_exterior_door"

	controller.tag_interior_door = "[airlock_name]_interior_door"

	controller.tag_interior_door = "[airlock_name]_interior_door"

	controller.tag_airpump = "[airlock_name]_airpump"

	//Airlock components tags

	chamber_sensor.id_tag = "[airlock_name]_chamber_sensor"

	exterior_door.id_tag = "[airlock_name]_exterior_door"

	interior_door.id_tag = "[airlock_name]_interior_door"

	airpump.id_tag = "[airlock_name]_airpump"

	airpump.dir = airpump_dir

	exterior_button.master_tag = "[airlock_name]_controller"

	interior_button.master_tag = "[airlock_name]_controller"

//	if(controller_type == 2)
//		exterior_sensor = new /obj/machinery/airlock_sensor(exterior_sensor_loc)
//		interior_sensor = new /obj/machinery/airlock_sensor(interior_sensor_loc)

	//Edit the variables for the airlock components (e.g. pixel_offset)

	if(pixel_offset_type == 2)
		exterior_button.pixel_x = 0


//This proc will hopefully make the code look less confusing and make it easier to debug. Hopefully.
//Only needs to specify the user for the their loc variable and then E for what loc to set (In a string)

/proc/ask_ac_loc(mob/user, var/E = "")
	switch(E)

		if("controller")
			switch(alert("Where should the Airlock Controller go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return

		if("chamber_sensor")
			switch(alert("Where should the Chamber Sensor go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return

		if("airpump")
			switch(alert("Where should the Airpump go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return

		if("exterior_door")
			switch(alert("Where should the Exterior Door go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return

		if("interior_door")
			switch(alert("Where should the Interior Door go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return

		if("interior_sensor")
			switch(alert("Where should the Interior Sensor go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return

		if("exterior_sensor")
			switch(alert("Where should the Exterior Sensor go?",,"This tile","Cancel"))
				if("This tile")
					return user.loc
				if("Cancel")
					return


/proc/ask_add_options(var/E = "")
	switch(E)

/*		if("airlock_name")
			switch(alert("What should the airlock be called?",,"Custom Name","Use area name","Cancel"))
				if("Custom Name")
					var/nameholder
					nameholder = input("What should the airlock be called?",,"airlock")
					return nameholder
				if("Use area name")
					return controller_loc:name
				if("Cancel")
					return*/

		if("controller_type")
			switch(alert("What type of Airlock Controller should it be?",,"Regular","Advanced","Cancel"))
				if("Regular")
					return 1
				if("Advanced")
					return 2
				if("Cancel")
					return

		if("airlock_type")
			switch(alert("What type of door should the airlocks be?",,"Standard","Non-Standard","Cancel"))
				if("Standard")
					return /obj/machinery/door/airlock/external
				if("Non-Standard")
					var/objholder
					objholder = text2path(input(usr,"Enter typepath:" ,"Typepath","/obj/machinery/door/airlock/external"))
					if(!ispath(objholder))
						objholder = /obj/machinery/door/airlock/external
						alert("That path is not allowed.")
					else
						if(ispath(objholder,/mob) && !check_rights(R_DEBUG,0))
							objholder = /obj/machinery/door/airlock/external
					return objholder
				if("Cancel")
					return






/client/proc/admin_make_airlock_experimental(mob/user as mob)
	set category = "Admin"
	set desc = "Prompts the user to set a number of points, as well as specify some additional information, then constructs an airlock from that."
	set name = "Make Airlock (Experimental)"

	var/airlock_name //Used for the naming of the ids and names of the airlock components
	var/airlock_type //0 = regular, 1 = advanced
	var/obj/machinery/embedded_controller/radio/advanced_airlock_controller/airlock_controller
	var/airpump_dir
	var/obj/machinery/atmospherics/unary/vent_pump/airlock_airpump

	switch(alert("What should the Airlock's name be?",,"Custom name","Use area name","Cancel"))
		if("Custom name")
			airlock_name = input("Choose a name for the airlock.","Airlock Name","airlock")
		if("Use area name")
			airlock_name = user.loc.name
		if("Cancel")
			return

	switch(alert("What type of airlock controller should the airlock have?",,"Regular","Advanced","Cancel"))
		if("Regular")
			airlock_type = 0
		if("Advanced")
			airlock_type = 1
		if("Cancel")
			return

	switch(alert("Where should the airlock controller go?",,"This tile","Cancel"))
		if("This tile")
			if(airlock_type)
				airlock_controller = new /obj/machinery/embedded_controller/radio/advanced_airlock_controller(user.loc)
				airlock_controller.id_tag = "[airlock_name]_controller"
				airlock_controller.tag_airpump = "[airlock_name]_airpump"
				airlock_controller.tag_chamber_sensor = "[airlock_name]_chamber_sensor"
				airlock_controller.tag_exterior_door = "[airlock_name]_exterior_door"
				airlock_controller.tag_interior_door = "[airlock_name]_interior_door"

			else
				airlock_controller = new /obj/machinery/embedded_controller/radio/airlock_controller(user.loc)
		if("Cancel")
			return

	switch(alert("Want to adjust the pixel offset of the airlock controller?",,"Yes","No"))
		if("Yes")
			for(var/i = 5; i >= 0; i -= 1)
				airlock_controller.pixel_x = text2num(input("Input X offset.",,"0"))
				airlock_controller.pixel_y = text2num(input("Input Y offset.",,"0"))
				airlock_controller.pixel_z = text2num(input("Input Z offset.",,"0"))
				if(i != 0)
					var/confirm = alert(user, "Is this what you want? Chances Remaining: [i]", "Confirmation", "Yes", "No")
					if(confirm == "Yes")
						break

	switch(alert("Where should the airpump go?",,"This tile","Cancel"))
		if("This tile")

			airlock_airpump = new /obj/machinery/atmospherics/unary/vent_pump/high_volume(user.loc)
			airlock_airpump.id_tag = "[airlock_name]_airpump"

			switch(alert("What direction should it face?",,"North or South","East or West"))
				if("North or South")
					switch(alert("North or South?",,"North","South"))
						if("North")
							airpump_dir = 1
						if("South")
							airpump_dir = 2
				if("East or West")
					switch(alert("East or West?",,"East","West"))
						if("East")
							airpump_dir = 4
						if("West")
							airpump_dir = 8

			airlock_airpump.dir = airpump_dir
			airlock_airpump.initialize_directions = airpump_dir

			var/obj/machinery/atmospherics/pipe/simple/P = new/obj/machinery/atmospherics/pipe/simple(get_step(airlock_airpump.loc,airpump_dir))

			if(airpump_dir == 2)
				airpump_dir = 1
			if(airpump_dir == 8)
				airpump_dir = 4

			P.dir = airpump_dir
			P.initialize_directions = airpump_dir
			var/turf/T = P.loc
			P.level = T.intact ? 2 : 1
			P.initialize()
			P.build_network()
			if (P.node1)
				P.node1.initialize()
				P.node1.build_network()
			if (P.node2)
				P.node2.initialize()
				P.node2.build_network()


		if("Cancel")
			return

*/


/mob/living/proc/rejuvenate()

	// restore all of a human's blood and get rid of any chemicals in it
	if(ishuman(src))
		var/mob/living/carbon/human/human_mob = src
		human_mob.reagents.clear_reagents()
		human_mob.restore_blood()

		// fix being a husk
		if(DISFIGURED in status_flags)
			status_flags &= ~DISFIGURED
		if(HUSK in mutations)
			mutations &= ~HUSK
			mutations &= ~NOCLONE
			human_mob.update_body(0)
			human_mob.update_mutantrace()

	// if the mob is a robot, fix its components and reset its emagg status
	if(isrobot(src))
		var/mob/living/silicon/robot/robot_mob = src
		for(var/datum/robot_component/R in robot_mob.components)
			R.brute_damage = 0
			R.electronics_damage = 0
			if(R.type != R.wrapped)
				R.wrapped = new R.type
			R.installed = 1
			R.powered = 1
			R.toggled = 1
			if(R.type == /obj/item/weapon/cell)
				robot_mob.cell = R.wrapped
		robot_mob.emagged = 0


	// shut down various types of badness
	setToxLoss(0)
	setOxyLoss(0)
	setCloneLoss(0)
	setBrainLoss(0)
	SetParalysis(0)
	SetStunned(0)
	SetWeakened(0)

	// shut down ongoing problems
	radiation = 0
	nutrition = 400
	bodytemperature = T20C
	sdisabilities = 0
	disabilities = 0

	// fix blindness and deafness
	blinded = 0
	eye_blind = 0
	eye_blurry = 0
	ear_deaf = 0
	ear_damage = 0
	heal_overall_damage(getBruteLoss(), getFireLoss())

	//Delete any shrapnel that happens to be in the player
	if(src.contents)
		for(var/A in contents)
			if(istype(A,/obj/item/weapon/shard/shrapnel))
				del(A)

	// fix all of our organs
	restore_all_organs()

	// remove the character from the list of the dead
	if(stat == 2)
		dead_mob_list -= src
		living_mob_list += src
		tod = null

	// restore us to conciousness
	stat = CONSCIOUS

	//temporary fix for people who are rejuv'd having insane losebreath variables and are still asleep.
	losebreath = 0
	sleeping = 0
	resting = 0
	update_canmove()

	// make the icons look correct
	regenerate_icons()

	hud_updateflag |= 1 << HEALTH_HUD
	hud_updateflag |= 1 << STATUS_HUD
	return

