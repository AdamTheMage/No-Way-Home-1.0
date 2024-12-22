extends Node2D

# references

@onready var player = get_node("PlayerCharacter")
@onready var playerfixated = get_node("PlayerCharacter/Spaceship")
@onready var alienpath = get_node("PlayerCharacter/AlienPath2D/AlienPathFollow2D")

#variables
var alienskilled = 0

# Starting Spawns
func _ready():
	spawn_alien1()
	spawn_alien1()
	spawn_alien1()
	spawn_alien1()
	spawn_stardust()
	spawn_stardust()
	spawn_stardust()
	spawn_stardust()

##################################################################################################
# Random Alien1 Spawning
func spawn_alien1():
	var alien1 = preload("res://Survivor Arcade Game/Scenes/alien1.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien1.global_position = alienpath.global_position
	add_child(alien1)


func _on_alien_1_timer_timeout() :
	spawn_alien1()

##################################################################################################
# Random Alien2 Spawning
func spawn_alien2():
	var alien2 = preload("res://Survivor Arcade Game/Scenes/alien2.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien2.global_position = alienpath.global_position
	add_child(alien2)


func _on_alien_2_timer_timeout() :
	spawn_alien2()
##################################################################################################
# Random Alien3 Spawning
func spawn_alien3():
	var alien3 = preload("res://Survivor Arcade Game/Scenes/alien3.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien3.global_position = alienpath.global_position
	add_child(alien3)


func _on_alien_3_timer_timeout() :
	spawn_alien3()
	
##################################################################################################
# Random Alien4 Spawning
func spawn_alien4() :
	var alien4 = preload("res://Survivor Arcade Game/Scenes/alien4.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien4.global_position = alienpath.global_position
	add_child(alien4)

func _on_alien_4_timer_timeout() :
	spawn_alien4()


##################################################################################################
# Random Stardust Spawning- insane multipurpose area defining spawn code!

var num_stardust = 0

func spawn_stardust() :
	var new_stardust = preload("res://Survivor Arcade Game/Scenes/fuel_system.tscn").instantiate()
	
	var rand_x
	var rand_y
	randomize()
	rand_x = randf_range(105 , 3000)
	rand_y = randf_range(96 , 1715)
	new_stardust.global_position  = Vector2(rand_x , rand_y)
	
	add_child(new_stardust)
	num_stardust += 1

func _on_stardusttimer_timeout() :
	if num_stardust <= 20 :
		spawn_stardust()

##################################################################################################
# Random Drone Spawning- insane multipurpose area defining spawn code!

func spawn_dronepickup() :
	var new_dronepickup = preload("res://Survivor Arcade Game/Scenes/dronepickup.tscn").instantiate()
	
	var rand_x
	var rand_y
	randomize()
	rand_x = randf_range(105 , 3000)
	rand_y = randf_range(96 , 1715)
	new_dronepickup.global_position  = Vector2(rand_x , rand_y)
	
	get_node("/root/Game/Pickups").call_deferred("add_child",new_dronepickup)

# Adding the Drone :

var drone_count = 0

func add_drone() :
	drone_count += 1
	if drone_count == 1 :
		var new_drone45 = preload("res://Survivor Arcade Game/Scenes/drone45.tscn").instantiate()
		player.call_deferred("add_child", new_drone45)
	if drone_count == 2 :
		var new_drone225 = preload("res://Survivor Arcade Game/Scenes/drone225.tscn").instantiate()
		player.call_deferred("add_child", new_drone225)
	if drone_count == 3 :
		var new_drone135 = preload("res://Survivor Arcade Game/Scenes/drone135.tscn").instantiate()
		player.call_deferred("add_child", new_drone135)
	if drone_count == 4 :
		var new_drone315 = preload("res://Survivor Arcade Game/Scenes/drone315.tscn").instantiate()
		player.call_deferred("add_child", new_drone315)
##################################################################################################
# Heavy Weapon :
#var heavy_pickups = 0
var weaponcount = 0

func add_heavyweapon() :
	weaponcount += 1
	if weaponcount == 1 :
		var left_heavy = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_left.tscn").instantiate()
		playerfixated.call_deferred("add_child", left_heavy)
		
	if weaponcount == 2 :
		var right_heavy = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_right.tscn").instantiate()
		playerfixated.call_deferred("add_child", right_heavy)
##################################################################################################




##################################################################################################

func _on_player_character_playerhealth_depleted():
	print ("dead")
	%GameOverScreen.visible = true
	get_tree().paused = true

##################################################################################################
# Level Changes
var level2 = false
var level3 = false

func _on_player_character_level_2() :
	level2 = true


func _on_player_character_level_3() :
	level3 = true
