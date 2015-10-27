//I'm adding /salus to all of this so that I can easily find it in-game by searching for that.
/obj/machinery/power/rust_core/salus/preset

	New()
		..()
		anchored = 1
		state = 2
		connect_to_network()
		src.directwired = 1