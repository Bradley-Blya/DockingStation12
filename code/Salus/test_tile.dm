//This is to test using matrices in the BYOND code for anything that I can, which I believe is only animation.

/turf/simulated/floor/salus/spin_test
	var/matrix/M = matrix()
	var/testing_var = 1


/*	proc/process()
		spawn(0)
			while(src.loc)
				M.Turn(15)
				src.transform = M
				sleep(10)*/


/obj/item/weapon/salus/spin_test
	var/matrix/M = matrix()
	var/testing_var = 1
	icon_state = "sledgehammer"


/obj/item/weapon/salus/spin_test/process()
	while(src.loc)
//		sleep(1)
		var/n = 1
		for(var/i = 10; i > 0; i--)
			M.Turn(36*n)
//			M.Translate(1,-1)
			src.transform = M
			n++
			sleep(5)

/obj/item/weapon/salus/spin_test/New()
	..()
	src.process()


/turf/simulated/floor/salus/scale_test
	var/matrix/M = matrix()



/obj/item/weapon/salus/spin_test/proc/update_test_icons()
	if(src.testing_var)
		for(var/i = 5; i > 0; i--)
			var/matrix/M = matrix()
			M.Turn(5*i)
			M.Translate(1,-6)
			src.transform = M
			sleep(10)

/obj/item/weapon/salus/spin_test/proc/test_translate()
	if(src.testing_var)
		for(var/i = 5; i > 0; i--)
			var/matrix/M = matrix()
			M.Translate(1,-6)
			src.transform = M
			sleep(10)
