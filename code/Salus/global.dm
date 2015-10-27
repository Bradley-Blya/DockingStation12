//This file is just incase I need to make an ammendment to the global variables or procs. Such as adding a list for all of the areas on the station!

var/list/station_areas = list()

var/list/const_drones = list()

//For the log files. Most of these will not be used for a bit
var/diaryofdruggies = null
var/diaryofdocs = null
var/diaryofhackers = null
var/diaryofcargo = null
var/diaryofadmins = null
var/diaryofdeath = null //Don't know how well this will work, but I oughta try it at least!

///mob/living/carbon/var/chemical_log = new/list()

//Used for the construction drone control. Need them for the player to be able to do more than simply move the drone about.

#define ui_drone_action_slot1 "1:6,13:26"
#define ui_drone_action_slot2 "2:8,13:26"
#define ui_drone_action_slot3 "3:10,13:26"
#define ui_drone_action_slot4 "4:12,13:26"
#define ui_drone_action_slot5 "5:14,13:26"

//Used for the sub buttons

#define ui_drone_sub_action_slot1 "1:6,12:26"
#define ui_drone_sub_action_slot2 "2:8,12:26"
#define ui_drone_sub_action_slot3 "3:10,12:26"
#define ui_drone_sub_action_slot4 "4:12,12:26"
#define ui_drone_sub_action_slot5 "5:14,12:26"