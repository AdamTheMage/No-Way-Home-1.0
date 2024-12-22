extends Container

#signals
signal healthpack
signal level2
signal level3
signal level4

# Stardust 
var stardust_count = 0

@onready var stardust_label = %StardustAcquired
@onready var alien2 = get_node("/root/Game")
@onready var Level1Music = get_node("/root/Game/Music/Level1Music")
@onready var Level2Music = get_node("/root/Game/Music/Level2Music")
@onready var Level3Music = get_node("/root/Game/Music/Level3Music")
@onready var Foreground = get_node("/root/Game/Foreground")
@onready var Midground = get_node("/root/Game/Midground")



# Level Up :

var kills_needed = 20
var stardust_needed = 5

func level_up2() :
	kills_needed = 50
	stardust_needed = 10
	level2.emit()
	Foreground.get_node("Foregroundlevel2").visible = true
	Foreground.get_node("ForegroundFader").play("level2")
	Midground.get_node("Midgroundlevel2").visible = true
	Midground.get_node("MidgroundFader").play("level2")
	%levelborderanimations.play("level2")
	%CurrentLevel.text = "Level: 2" 
	%stardustborderanimations.play("level2")
	Level1Music.stream_paused = true
	Level2Music.play(float("res://Survivor Arcade Game/Music/THEME 1 OG EXTENDED.mp3"))
	get_parent().get_parent().get_parent().spawn_dronepickup()
	get_node("/root/Game/Timers/alien2timer").start()

func level_up3() :
	kills_needed = 100
	stardust_needed = 15
	level3.emit()
	Foreground.get_node("Foregroundlevel3").visible = true
	Foreground.get_node("ForegroundFader").play("level3")
	Midground.get_node("Midgroundlevel3").visible = true
	Midground.get_node("MidgroundFader").play("level3")
	%levelborderanimations.play("level3")
	%CurrentLevel.text = "Level: 3" 
	%stardustborderanimations.play("level3")
	Level2Music.stream_paused = true
	Level3Music.play(float("res://Survivor Arcade Game/Music/Iteration-0.mp3"))
	get_parent().get_parent().get_parent().spawn_dronepickup()
	get_node("/root/Game/Timers/alien3timer").start()

func level_up4() :
	kills_needed = 150
	stardust_needed = 20
	level4.emit()
	#Foreground.get_node("Foregroundlevel3").visible = true
	#Foreground.get_node("ForegroundFader").play("level3")
	#Midground.get_node("Midgroundlevel3").visible = true
	#Midground.get_node("MidgroundFader").play("level3")
	#%levelborderanimations.play("level3")
	#%CurrentLevel.text = "Level: 3" 
	#%stardustborderanimations.play("level3")
	#Level2Music.stream_paused = true
	#Level3Music.play(float("res://Survivor Arcade Game/Music/Iteration-0.mp3"))
	#get_parent().get_parent().get_parent().spawn_dronepickup()
	get_node("/root/Game/Timers/alien4timer").start()
func level_up5() :
	pass
	# if 500 kills reached, play "LEVEL_COMPLETE" screen
#################################################################################################
# Kill Counter

var alien1kill_count = 0
var alien2kill_count = 0
var alien3kill_count = 0
var alien4kill_count = 0

var kill_count = (alien1kill_count + alien2kill_count + alien3kill_count + alien4kill_count)

func add_alien1kill() :
	alien1kill_count += 1
	kill_count += 1
	%KillCount.text = "Kills:" + " " + str(kill_count) + " / " + str(kills_needed)
	if kill_count == 2 :
		level_up2()
	if kill_count == 5 :
		level_up3()
	if kill_count == 8 :
		level_up4()
	
func add_alien2kill() :
	alien2kill_count += 1
	kill_count+= 1
	%KillCount.text = "Kills:" + " " + str(kill_count) + " / " + str(kills_needed)
	if kill_count == 2 :
		level_up2()
	if kill_count == 5 :
		level_up3()
	
func add_alien3kill() :
	alien3kill_count += 1
	kill_count+= 1
	%KillCount.text = "Kills:" + " " + str(kill_count) + " / " + str(kills_needed)
	if kill_count == 2 :
		level_up2()
	if kill_count == 5 :
		level_up3()
	
func add_alien4kill() :
	alien4kill_count += 1
	kill_count+= 1
	%KillCount.text = "Kills:" + " " + str(kill_count) + " / " + str(kills_needed)
	if kill_count == 2 :
		level_up2()
	if kill_count == 5 :
		level_up3()
#################################################################################################
# Add Stardust :
func add_stardust() :
	healthpack.emit()
	stardust_count += 1
	stardust_label.text = str(stardust_count)
	if stardust_count == 5 and kill_count < 20 :
		level_up2()
	if stardust_count == 10 and kill_count < 50 :
		level_up3()
#################################################################################################
