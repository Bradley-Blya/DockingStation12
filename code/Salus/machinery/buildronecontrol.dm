/*Going to start over with the builder drone's code in this file. Need to get my priorities in check for this.

	Main Priorities:
		1 - Get the control console to work like a camera console, but without it asking if you want to swap cameras
		2 - Figure out how to get the user's input from mouse clicks (Use world << "Example Test" for this one.
			- Try to get Click(); DblClick(); MouseDrop(); MouseDrag() to work through the console
		3 - Make the drone respond to these commands in some way at least. That will pave the way for the full functionality

	Secondary Priorities:
		1 - Make the Drone require a power cell.
		2 - Give the Drone slave drones that make construction take less time
		3 - Make a new HUD for use with the console, so that the user can easily click on an icon in order to select a job to perform (e.g. Lay Cable)
		4 - Spawn the Drone in with limited supplies that need to be refilled every once and awhile. This one will probably not be implemented immediately
			if at all.
*/


/obj/machinery/computer3/salus/buildronecontrol
	default_prog = /datum/file/program/security/salus/buildronecontrol
	spawn_parts			= list(/obj/item/part/computer/storage/hdd,/obj/item/part/computer/networking/cameras)
	spawn_files 		= list(/datum/file/camnet_key/buildronecontrol)
	icon_state			= "frame-sec"
	var/obj/machinery/salus/buildrone/linked_drone = null
	var/booted_up = 0 	//Used to resolve issues with the initial click to access the console becoming a command and used by the update_drone_buttons() proc to know whether to add or remove the drone buttons

	New()
		..()
		const_drones += src

	Del()
		..()
		const_drones -= src


/datum/file/camnet_key/buildronecontrol
	name = "Construction Drone Camera Network Key"
	title = "drones"
	desc = "Monitors the Construction Drones."
	networks = list("BuilDrone")

//Shameless copy-paste is shameless
/datum/file/program/security/salus/buildronecontrol
	name			= "CTD monitor"
	desc			= "Connets to the Nanotrasen CTD Camera Network"
	image			= 'icons/ntos/camera.png'
	active_state	= "camera-static"

	var/linked_user = null
	var/obj/machinery/salus/buildrone/linked_drone = null

	interact()
		..()
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			linked_user = H
			H.update_drone_buttons()
/*			if(linked_user.machin:booted_up)
				sleep()
				linked_user.machine:booted_up = 1*/

//Remote control: mouse with a modifier
/atom/AltClick()
	..()
	if(istype(usr.machine,/obj/machinery/computer3/salus/buildronecontrol))
		world << "Alt Click Registered."


//Remote control: mouse.
/atom/Click(loc)
	..()
	if(istype(usr.machine,/obj/machinery/computer3/salus/buildronecontrol))
		var/mob/living/carbon/human/user = usr
		var/obj/machinery/salus/buildrone/B = user.machine:linked_drone
		world << "Click Registered."
		if(B)
			var/tempdist = get_dist(B.loc,loc)
			if(tempdist > 1)
				for(var/i = 0; i == tempdist; i++)
					if(B.Move(get_step(B.loc,get_dir(B.loc,loc))))
						world << "Drone moved. [tempdist] moves remaining."
					else
						world << "Drone not moved."

			else
				if(B.Move(loc))
					world << "Drone moved."
		else
			world << "Drone not detected properly."



//Remote control: mouse.
/atom/DblClick()
	..()
	if(istype(usr.machine,/obj/machinery/computer3/salus/buildronecontrol))
		world << "DblClick Registered."

//Remote control: arrow keys.
/mob/Move(n,direct)
	if(istype(machine,/obj/machinery/computer3/salus/buildronecontrol))
		world << "[n] , [direct]"
//		if(usr:machine:linked_drone)
//			user.macher:linked_drone.Move(n)
		return
	return ..(n,direct)


/obj/machinery/salus/buildrone
	name = "BuilDrone Unit"
	desc = "A Nanotrasen CT Drone."
	icon = 'icons/mob/custom-synthetic.dmi'
	icon_state = "ravensdale-Engineering"

	var/drone_id = null
	var/drone_name = null
	var/obj/machinery/camera/camera = null			//So the control console can look through the "eyes" of the drone
	var/obj/machinery/computer3/salus/buildronecontrol/linked_console = null
	var/booted_up = 0 								//A lazy way to fix the robot responding with the first click the player does to access the console
	var/list/drone_action_command_list = list()		//An attempt to get the HUD Elements to spawn when interacting with the construction control console


	New()
		..()
		const_drones += src
		//Set an id for the drone to allow there to be multiple drones
		if(!drone_id)
			drone_id = rand(1, 999)

		if(!drone_name && drone_id)
			drone_name = "BuilDrone Unit [drone_id]"
			name = drone_name

		if(!camera)
			camera = new /obj/machinery/camera(src)
			camera.c_tag = drone_name
			camera.network = list("BuilDrone")

		linked_console = find_console()

		if(linked_console)
			linked_console.linked_drone = src

		var/cable_lay = new /obj/screen/item_action/salus/spawn_assist/cable_lay
		drone_action_command_list += cable_lay



	Del()
		..()
		const_drones -= src

	proc/find_console()
		for(var/obj/machinery/computer3/salus/buildronecontrol/S in const_drones)
			if(!S.linked_drone)
				return S

/datum/hud
	var/list/obj/screen/item_action/drone_action_list = list()	//Used for controlling the construction drones
	var/list/obj/screen/item_action/drone_sub_action_list = list()

/*
		Things that should be select-able via the drone buttons (Not in any particular order):

		1 - Lay Cable
		2 - Lay Pipes
		3 - Install machinery(?)
		4 - Build Flooring		]These two might be better to have on a single button
		5 - Build Walls			]
		6 - Build Misc. Structures (e.g. Reinforeced Windows (one direction), grilles)

		Might be able to make more buttons pop up whenever a "main" button is pressed, to bring up more options.
		If I do, here are the possible categories (No particular order for the final product):

		1 - Under-Tile
			1 - Lay Cable
			2 - Lay Pipe
		2 - Full Tile
			1 - Build Plating (will be /airless and require a seperate drone slave for floor tiles)
			2 - Build Walls	(Not sure about dividing it up into two seperate sub-categories. Might just have it like how build-mode handles it(Single click = Regular Wall; Click again = Reinforced Wall))
				1 - Regular
				2 - Reinforced
		3 - Machinery
			1 - Airlock
				Type:
					1 - Default
					2 - Default Glass
					3 - Custom		(Will require user input for the path)
					4 - Custom Glass
			2 - APC (Limit one per area)
				Variables:
					1(0) - Automatic Dir
					2(1) - Forced Dir
			3 - Air Alarm (Limit one per area)
			4 - Lights
				Types:
					1 - Regular
					2 - Small
					3 - Spot	(Cause why not?)
				Variables:
					1 - Forced Dir	(So that an automatic setting can be overwritten)
		4 - Misc
			1 - Reinforced Glass	(Might remove this option and make an option to construct a window that includes a grille inbetween all of the one-direction windows)
				1 - Dir Variable (Should handle this just like how build mode does)
					1 		- North
					2 		- South
					3(4) 	- East
					4(8)	- West
					5		- Full (Full Tile)
			2 - Grille				(Same as Reinforced Glass)
			3 - Tiles



*/


//Mostly just copied and pasted. Trying to figure it out before making my own code for this, though it will likely be very similar
/*
/mob/living/carbon/human/proc/update_drone_buttons()
	var/num = 1
	if(!hud_used)	return
	if(!client)		return	//No point if there ain't anyone to see the pretty pictures, eh?

	if(!hud_used.hud_shown)	//Hud toggled to minimal
		return

	client.screen -= hud_used.drone_action_list		//Resets the drone_action_list list so that it can be made properly. This is mainly for the item action code, so I probably don't need this to be here.

	hud_used.drone_action_list = list()			//Makin' da list!
	if(src.machine && istype(src.machine, /obj/machinery/computer3/salus/buildronecontrol))
		var/obj/screen/item_action/A = new(hud_used)

		A.icon = ui_style2icon(client.prefs.UI_style)
		A.icon_state = "template"
		var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
		img.pixel_x = 0
		img.pixel_y = 0
		A.overlays += img

//		if(I.action_button_name)
//			A.name = I.action_button_name
//		else
		A.name = "Use Testing Tile"
		A.owner = src.machine
		hud_used.drone_action_list += A
		switch(num)
			if(1)
				A.screen_loc = ui_drone_action_slot1
			if(2)
				A.screen_loc = ui_drone_action_slot2
			if(3)
				A.screen_loc = ui_drone_action_slot3
			if(4)
				A.screen_loc = ui_drone_action_slot4
			if(5)
				A.screen_loc = ui_drone_action_slot5
//				break //5 slots available, so no more can be added.
		num++
		src.client.screen += src.hud_used.drone_action_list
*/


//Generates the main buttons for the drone controls
/mob/living/carbon/human/proc/update_drone_buttons()
//	var/num = 1
	if(!client)		return
	if(!hud_used)	return

	if(!hud_used.hud_shown)	//Hud toggled to minimal
		return

	world << "Break 2"

	if(src.machine && istype(src.machine, /obj/machinery/computer3/salus/buildronecontrol))	//booted_up will be the variable on the console that takes one or less seconds to set to one so that the initial click isn't registered as a command and so that this proc knows whether or not it's removing the buttons
		hud_used.drone_action_list = list()			//Makin' da list!
		world << "Break 3"
		for(var/obj/screen/item_action/I in src.machine:linked_drone:drone_action_command_list)
			world << "Detected Component: [I]"
			var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
			A.icon = ui_style2icon(client.prefs.UI_style)
			A.icon_state = "template"
			var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
			img.pixel_x = 0
			img.pixel_y = 0
			A.overlays += img
			A.name = "Select Sub-Tile Construction"
			A.owner = src.machine
			hud_used.drone_action_list += A
			A.screen_loc = ui_drone_action_slot1
			if(A)
				world << "Spawned a button. Break 6"

		for(var/i = 0; i > 3; i++)
			var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
			world << "Performing For loop. Break 4"
			switch(i)
				if(0)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)	//Using the same icon for now, but will use icons that better depict the action later on
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					A.name = "Select Sub-Tile Construction"
					A.owner = src.machine
					hud_used.drone_action_list += A
					A.screen_loc = ui_drone_action_slot1
					world << "Spawned a button. Break 5"
				if(1)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					A.name = "Select Tile Construction"
					A.owner = src.machine
					hud_used.drone_action_list += A
					A.screen_loc = ui_drone_action_slot2
				if(2)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					A.name = "Select Machinery Construction"
					A.owner = src.machine
					hud_used.drone_action_list += A
					A.screen_loc = ui_drone_action_slot3
				if(3)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					A.name = "Select Misc. Construction"
					A.owner = src.machine
					hud_used.drone_action_list += A
					A.screen_loc = ui_drone_action_slot4
				if(4)
					break	//Done for now, so just finish the loop
		src.client.screen += src.hud_used.drone_action_list

			/*
			A.icon = ui_style2icon(client.prefs.UI_style)
			A.icon_state = "template"
			var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
			img.pixel_x = 0
			img.pixel_y = 0
			A.overlays += img
			A.name = "Use Testing Tile"
			A.owner = src.machine
			hud_used.drone_action_list += A*/	//Template code for the above

	else if(src.machine && istype(src.machine, /obj/machinery/computer3/salus/buildronecontrol))	//If booted up, then remove buttons.
		client.screen -= hud_used.drone_action_list

	/*

/proc/spawn_drone_button(var/num, var/main_num, var/main)	//main_num: 1 = Sub-Tile Construction; 2 = Tile Construction; 3 = Machine Construction; 4 = Misc. Construction
	var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
	A.icon = ui_style2icon(client.prefs.UI_style)
	A.icon_state = "template"
	var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
	img.pixel_x = 0
	img.pixel_y = 0
	A.overlays += img
	//Decide what to name the button
	if(main)
		switch(num)
			if(1)
				A.name = "Select Sub-Tile Construction"
			if(2)
				A.name = "Select Tile Construction"
			if(3)
				A.name = "Select Machine Construction"
			if(4)
				A.name = "Select Misc. Construction"
	else if(!main)	//if a sub-button
		switch(main_num)
			if(1)	//Sub-Tile
				switch(num)
					if(1)	//Cable Laying
						A.name = "Select Cable Laying"
					if(2)	//Pipe Laying
						A.name = "Select Pipe Laying"
			if(2)	//Tile
				switch(num)
					if(1)	//Plating
						A.name = "Select Plating Construction"
					if(2)	//Wall
						A.name = "Select Wall Construction"
			if(3)	//Machine
				switch(num)
					if(1)	//Airlock
						A.name = "Select Airlock Construction"
					if(2)	//APC
						A.name = "Select APC Construction"
					if(3)	//Air Alarm
						A.name = "Select Air Alarm Construction"
					if(4)	//Lights
						A.name = "Select Light Constuction"
			if(4)	//Misc.
				switch(num)
					if(1)	//Reinforced Window
						A.name = "Select Reinforced Window Construction"
					if(2)	//Grille
						A.name = "Select Grille Construction"
					if(3)	//Tiling
						A.name = "Select Tile Laying"
		switch(num)
			if(1)
				A.name = "Select Sub-Tile Construction"
			if(2)
				A.name = "Select Sub-Tile Construction"
			if(3)
				A.name = "Select Sub-Tile Construction"
			if(4)
				A.name = "Select Sub-Tile Construction"
	A.name = "Select Sub-Tile Construction"
	A.owner = src.machine
	hud_used.drone_action_list += A
	if(main)
		switch(num)
			if(1)
				A.screen_loc = ui_drone_action_slot1
			if(2)
				A.screen_loc = ui_drone_action_slot2
			if(3)
				A.screen_loc = ui_drone_action_slot3
			if(4)
				A.screen_loc = ui_drone_action_slot4
	else if(!main)
		switch(num)
			if(1)
				A.screen_loc = ui_drone_sub_action_slot1
			if(2)
				A.screen_loc = ui_drone_sub_action_slot2
			if(3)
				A.screen_loc = ui_drone_sub_action_slot3
			if(4)
				A.screen_loc = ui_drone_sub_action_slot4
		*/



/mob/living/carbon/human/proc/update_drone_sub_buttons(var/buttons_to_update = 0)	// 0 = Sub-Tile; 1 = Tile; 2 = Machinery; 3 = Misc
	if(!client)		return
	if(!hud_used)	return

	if(!hud_used.hud_shown)	//Hud toggled to minimal
		return

	if(src.machine && istype(src.machine, /obj/machinery/computer3/salus/buildronecontrol))
		hud_used.drone_sub_action_list = list()			//Makin' da list!
		switch(buttons_to_update)
			//Make the sub-buttons for Sub Tile construction
			if(0)
				for(var/i = 0; i >= 1; i++)
					var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)	//Using the same icon for now, but will use icons that better depict the action later on
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					switch(i)
						if(0)
							A.name = "Select Cable Laying"
						if(1)
							A.name = "Select Pipe Laying"
					A.owner = src.machine
					hud_used.drone_action_list += A
					switch(i)
						if(0)
							A.screen_loc = ui_drone_sub_action_slot1
						if(1)
							A.screen_loc = ui_drone_sub_action_slot2
			//Make the sub-buttons for Tile construction
			if(1)
				for(var/i = 0; i >= 1; i++)
					var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					switch(i)
						if(0)
							A.name = "Select Plating Construction"
						if(1)
							A.name = "Select Wall Construction"
					A.owner = src.machine
					hud_used.drone_action_list += A
					switch(i)
						if(0)
							A.screen_loc = ui_drone_sub_action_slot1
						if(1)
							A.screen_loc = ui_drone_sub_action_slot2
			//Make the sub-buttons for machinery construction
			if(2)
				for(var/i = 0; i >= 3; i++)
					var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)	//Using the same icon for now, but will use icons that better depict the action later on
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					switch(i)
						if(0)
							A.name = "Select Airlock Construction"
						if(1)
							A.name = "Select APC Construction"
						if(2)
							A.name = "Select Air Alarm Construction"
						if(3)
							A.name = "Select Light Construction"
					A.owner = src.machine
					hud_used.drone_action_list += A
					switch(i)
						if(0)
							A.screen_loc = ui_drone_sub_action_slot1
						if(1)
							A.screen_loc = ui_drone_sub_action_slot2
						if(2)
							A.screen_loc = ui_drone_sub_action_slot3
						if(3)
							A.screen_loc = ui_drone_sub_action_slot4
			//Make the sub-buttons for misc construction
			if(3)
				for(var/i = 0; i >= 2; i++)
					var/obj/screen/item_action/salus/drone_action/A = new(hud_used)
					A.icon = ui_style2icon(client.prefs.UI_style)
					A.icon_state = "template"
					var/image/img = image('icons/mob/custom-synthetic.dmi', A, "ravensdale-Engineering", 40)	//Using the same icon for now, but will use icons that better depict the action later on
					img.pixel_x = 0
					img.pixel_y = 0
					A.overlays += img
					switch(i)
						if(0)
							A.name = "Select Reinforced Window Construction"
						if(1)
							A.name = "Select Grille Construction"
						if(2)
							A.name = "Select Lay Tiling"
					A.owner = src.machine
					hud_used.drone_action_list += A
					switch(i)
						if(0)
							A.screen_loc = ui_drone_sub_action_slot1
						if(1)
							A.screen_loc = ui_drone_sub_action_slot2
						if(2)
							A.screen_loc = ui_drone_sub_action_slot3
		src.client.screen += src.hud_used.drone_action_list



/obj/screen/item_action/salus/drone_action

/obj/screen/item_action/salus/drone_action/Click()
	..()
	if(istype(usr.machine, /obj/machinery/computer3/salus/buildronecontrol))
		world << "Click Registered: Break 1"


/obj/screen/item_action/salus/spawn_assist/cable_lay
	name = "Testing Spawn Assist Screen Object"


//Screen Objects for use with the BuilDrone Control Console. Might not work.

/obj/screen/salus/test_1
	name = "Test_1"
	icon = 'icons/Testing/turf_analysis.dmi'
	icon_state = "on4_border"
	screen_loc = "CENTER-7,CENTER-7"


