/*
These lights will be used in case of a power outage, just so that the outlines of the hall ways can be seen by players.
Should make a lack of power to be immensely less annoying.

These lights should be very dull and not require any power.
*/

/obj/machinery/emergency_lights
	name = "Emergency Light"
	icon = 'icons/Axiom/power/emergency_lights.dmi'
	icon_state = "elight"
	anchored = 1
	layer = 5
	use_power = 0
	desc = "A tubular container with a faintly glowing substance in it. Lights the edges of hallways during power outages."
	var/brightness = 1
/*
	icon_state = "elight1"
	base_state = "elight"
	brightness = 2
	desc = "A tubular container with a faintly glowing substance in it. Lights the edges of hallways during power outages."
*/

/obj/machinery/emergency_lights/New()
	..()
	spawn(1)
		SetLuminosity(brightness)