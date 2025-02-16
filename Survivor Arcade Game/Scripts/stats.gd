extends Container

#signals
signal healthpack
signal level2
signal level3
signal level4
signal level5
signal level6

# Ensuring Levels Only Carry Out Their Function Once
var levelupped2 = false
var levelupped3 = false
var levelupped4 = false
var leveluppedboss1 = false
var levelupped6 = false


@onready var alien2 = get_node("/root/Game")
@onready var Level1Music = get_node("/root/Game/Music/Level1Music")
@onready var Level2Music = get_node("/root/Game/Music/Level2Music")
@onready var Level3Music = get_node("/root/Game/Music/Level3Music")
@onready var Foreground = get_node("/root/Game/Foreground")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var squadrendezvousanimation = get_node("/root/Game/PlayerCharacter/SquadRegroupAnimation")

# Level Up :
var soul_count = 0
var souls_needed = 20

func level_up2() :
	player.playerhealth += 50
	levelupped2 = true
	%SoulBar.min_value = soul_count
	souls_needed = 50
	level2.emit()
	%levelborderanimations.play("level2")
	%CurrentLevel.text = "Wave: 2" 
	get_node("/root/Game/Timers/alien2timer").start()

func level_up3() :
	%SoulBar.texture_over = load("res://Survivor Arcade Game/Stats UI/Soul_Overlay_Lv3&4.png")
	%SoulBar.texture_progress = load("res://Survivor Arcade Game/Stats UI/Bar_Lv3&4.png")
	player.playerhealth += 50
	levelupped3 = true
	%SoulBar.min_value = soul_count
	souls_needed = 100
	level3.emit()
	%levelborderanimations.play("level3")
	%CurrentLevel.text = "Wave: 3" 
	Level1Music.stream_paused = true
	Level2Music.play(float("res://Survivor Arcade Game/Music/THEME 1 OG EXTENDED.mp3"))
	get_node("/root/Game/Timers/alien3timer").start()
	get_node("/root/Game/Timers/alien4timer").start()

func level_up4() :
	player.playerhealth += 50
	levelupped4 = true
	%SoulBar.min_value = soul_count
	souls_needed = 150
	level4.emit()
	%levelborderanimations.play("level4")
	%CurrentLevel.text = "Wave: 4" 
	#Level3Music.stream_paused = true
	#Level4Music.play(float("res://Survivor Arcade Game/Music/x.mp3"))

func level_upboss1() :
	player.playerhealth += 50
	leveluppedboss1 = true
	%SoulBar.visible = false
	%LevelBorder.visible = false
	%CurrentLevel.visible = false
	var lenurcher = preload("res://Survivor Arcade Game/Scenes/lenurcher.tscn").instantiate()
	lenurcher.global_position = %Spaceship.global_position + Vector2(0, -65)
	get_node("/root/Game").call_deferred("add_child", lenurcher)
	var newbar = %LenurcherBar
	newbar.visible = true
	level5.emit()
	Level2Music.stream_paused = true
	Level3Music.play(float("res://Survivor Arcade Game/Music/Iteration-0.mp3"))

func lenurcherdead() :
	# %LevelBorder.visible = true
	# %CurrentLevel.visible = true
	print ("lenurcherdyineafa")
	squadrendezvousanimation.play("squadregroup")
	var newbar = %LenurcherBar
	newbar.visible = false
	# if levelupped6 == false :
		# level_up6()
	# Game currently finishes here :

func level_up6() :
	%SoulBar.visible = true
	player.playerhealth += 50
	levelupped6 = true
	souls_needed = 250
	level6.emit()
	#Level5Music.stream_paused = true
	#Level6Music.play(float("res://Survivor Arcade Game/Music/x.mp3"))

#################################################################################################
# Kill Counter

var alien1kill_count = 0
var gugglerkill_count = 0
var alien2kill_count = 0
var alien3kill_count = 0
var alien4kill_count = 0

var kill_count = (alien1kill_count + gugglerkill_count + alien2kill_count + alien3kill_count + alien4kill_count)

func add_alien1kill() :
	alien1kill_count += 1
	kill_count += 1
	%KillCount.text = "Kills:" + " " + str(kill_count)
	
func add_gugglerkill() :
	gugglerkill_count += 1
	kill_count += 1
	%KillCount.text = "Kills:" + " " + str(kill_count) 
	
func add_alien2kill() :
	alien2kill_count += 1
	kill_count+= 1
	%KillCount.text = "Kills:" + " " + str(kill_count) 
	
func add_alien3kill() :
	alien3kill_count += 1
	kill_count+= 1
	%KillCount.text = "Kills:" + " " + str(kill_count) 
	
func add_alien4kill() :
	alien4kill_count += 1
	kill_count+= 1
	%KillCount.text = "Kills:" + " " + str(kill_count) 

#################################################################################################
# Add Stardust :
func add_stardust() :
	healthpack.emit()
#################################################################################################
# Checks for SOULS UPDATES :
func _on_soulcheck_timeout() :
	soul_count = player.souls
	%SoulBar.value = soul_count
	%SoulBar.max_value = souls_needed
	if soul_count >= 20 and levelupped2 == false :
		level_up2()
	if soul_count >= 50 and levelupped3 == false :
		level_up3()
	if soul_count >= 100 and levelupped4 == false :
		level_up4()
	if soul_count >= 150 and leveluppedboss1 == false :
		level_upboss1()
#################################################################################################
