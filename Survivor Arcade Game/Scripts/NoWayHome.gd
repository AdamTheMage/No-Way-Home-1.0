extends Node2D

signal initialmanualtrue

# references

@onready var player = get_node("PlayerCharacter")
@onready var pocketbuttons = get_node("PlayerCharacter/UI/stats/statslayer/PocketEditionButtonContainer")
@onready var pocketpause = get_node("PlayerCharacter/UI/stats/statslayer/PocketEditionPause")
@onready var playerfixated = get_node("PlayerCharacter/Spaceship")
@onready var alienpath = get_node("PlayerCharacter/Paths/AlienPath2D/AlienPathFollow2D")
@onready var weatherpath = get_node("PlayerCharacter/Paths/WeatherPath2D/WeatherPathFollow2D")
@onready var outsideplayerviewweatherpath = get_node("PlayerCharacter/Paths/WeatherPathOutsideView2D/WeatherPathOutsideViewFollow2D")
@onready var hammerpath = get_node("PlayerCharacter/Paths/HammerPath2D/HammerPathFollow2D")

# Mob count :
var alien1_count = 0
var guggler_count = 0 
var alien2_count = 0
var alien3_count = 0
var alien4_count = 0

#variables :
var alienskilled = 0
var weatherchance = 0
var game_paused = false
var initialmanual = false

# Boss Situations :
var bluehell = false

# Versions :
var pocketedition = false

# Starting Spawns
func _ready():
	# Finds what platform its on :
		# Pocket Edition :
	if DisplayServer.is_touchscreen_available() :
		pocketedition = true
		# Display Pocket Edition Buttons :
		pocketbuttons.visible = true
		pocketpause.visible = true
		
		%StartingManual.scale.x = 1.269
		%StartingManual.scale.y = 1.269
		%StartingManual.position.x = -37.304
		%StartingManual.position.y = 1.393
		
		# Camera :
		%PlayerCamera.zoom.x = 15
		%PlayerCamera.zoom.y = 15
	else :
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		pocketedition = false
		# Camera :
		%PlayerCamera.zoom.x = 7.5
		%PlayerCamera.zoom.y = 7.5
		# Hide Pocket Edition Buttons :
		pocketbuttons.visible = false
		pocketpause.visible = false
		
	# The rest :
	get_viewport().size = DisplayServer.screen_get_size()
	Engine.max_fps = 60
	Engine.time_scale = 1
	if pocketedition == false :
		for i in range(100) :
			initial_procedural_spawn()
	elif pocketedition == true :
		for i in range(10) :
			initial_procedural_spawn()
	%GamePausedScreen.visible = true
	%NoWayHomeTitle.visible = false
	%RestartButton.visible = false
	%SettingsButton.visible = false
	%QuitButton.visible = false
	%StartingManual.visible = true
	%ManualX.visible = false
	%boosttobegin.visible = true
	%VictoryVignette.material.set("shader_parameter/Vignette_opacity" , 0 )
	%Vignette.material.set("shader_parameter/Vignette_opacity" , 0 )
	# %boosttobeginanimation.play("boosttobegin")
	initialmanual = true
	initialmanualtrue.emit()
	get_tree().paused = true
	for i in range(4) :
		spawn_alien1()
	
##################################################################################################
# Random Alien1 Spawning
func spawn_alien1():
	randomize()
	var alien1 = preload("res://Survivor Arcade Game/Scenes/alien1.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien1.global_position = alienpath.global_position
	add_child(alien1)


func _on_alien_1_timer_timeout() :
	if level == 1 :
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
	if level == 2 :
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
		spawn_alien1()
	if level == 3 :
		if alien1_count < 25 :
			for i in range(9) :
				spawn_alien1()
				await get_tree().create_timer(0.1).timeout
	if level == 4 :
		if alien1_count < 25 :
			for i in range(5) :
				spawn_alien1()
				await get_tree().create_timer(0.1).timeout
	if level == 5 :
		if alien1_count < 25 :
			for i in range(12) :
				spawn_alien1()
				await get_tree().create_timer(0.1).timeout
##################################################################################################
# Random Guggler Spawning
func spawn_guggler():
	randomize()
	var guggler = preload("res://Survivor Arcade Game/Scenes/guggler.tscn").instantiate()
	alienpath.progress_ratio = randf()
	guggler.global_position = alienpath.global_position
	get_node("/root/Game").call_deferred("add_child",guggler)

func _on_gugglertimer_timeout() :
	if level == 1 :
		if guggler_count < 7 :
			spawn_guggler()
	if level == 2 :
		if guggler_count < 7 :
			spawn_guggler()
			await get_tree().create_timer(0.1).timeout
			spawn_guggler()
	if level == 3 :
		if guggler_count < 7 :
			spawn_guggler()
			await get_tree().create_timer(0.1).timeout
			spawn_guggler()
			await get_tree().create_timer(0.1).timeout
			spawn_guggler()
	if level == 4 :
		if guggler_count < 7 :
			spawn_guggler()
	if level == 5 :
		if guggler_count < 7 :
			spawn_guggler()

##################################################################################################
# Random Alien2 Spawning
func spawn_alien2():
	randomize()
	var alien2 = preload("res://Survivor Arcade Game/Scenes/alien2.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien2.global_position = alienpath.global_position
	get_node("/root/Game").call_deferred("add_child",alien2)


func _on_alien_2_timer_timeout() :
	if level == 2 :
		if alien2_count < 12 :
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
	if level == 3 :
		if alien2_count < 12 :
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
	if level == 4 :
		if alien2_count < 12 :
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
	if level == 5 :
		if alien2_count < 12 :
			spawn_alien2()
			await get_tree().create_timer(0.1).timeout
			spawn_alien2()
	
##################################################################################################
# Random Alien3 Spawning
func spawn_alien3():
	randomize()
	var alien3 = preload("res://Survivor Arcade Game/Scenes/alien3.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien3.global_position = alienpath.global_position
	add_child(alien3)


func _on_alien_3_timer_timeout() :
	if level == 3 :
		if alien3_count < 5 :
			spawn_alien3()
	if level == 4 :
		%alien3timer.wait_time = 6
		if alien3_count < 5 :
			spawn_alien3()
	if level == 5 :
		if alien3_count < 5 :
			%alien3timer.wait_time = 8
	
##################################################################################################
# Random Alien4 Spawning
func spawn_alien4() :
	randomize()
	var alien4 = preload("res://Survivor Arcade Game/Scenes/alien4.tscn").instantiate()
	alienpath.progress_ratio = randf()
	alien4.global_position = alienpath.global_position
	get_node("/root/Game").call_deferred("add_child",alien4)

func _on_alien_4_timer_timeout() :
	if level == 4 :
		%alien4timer.wait_time = 6
		if alien4_count < 7 :
			spawn_alien4()
	if level == 5 :
		%alien4timer.wait_time = 12
		if alien4_count < 7 :
			spawn_alien4()
			await get_tree().create_timer(0.1).timeout
			spawn_alien4()

##################################################################################################
# Boss Situations :
	# Lenurcher :
func _on_lenurcher_bluehell() :
	bluehell = true
	await get_tree().create_timer(0.3).timeout
	bluehell = false

##################################################################################################

##################################################################################################
# Procedural Spawning
# Spawning position variables
var areax = 0
var areay = 0
var randoutsideofviewx = 0
var randoutsideofviewy = 0
var despawnboundary = 0
var asteroidcount = 0
var posornegproceduralx = 0
var posornegproceduraly = 0
var spawntoporside = 0

# Chances of extras spawning :
var shipmentchance = 0

# Background :
var backgroundasteroidcount = 0
 
func initial_procedural_spawn() :
	if asteroidcount <= 35 and pocketedition == false :
		randomize()
		# Spawning :
		areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
		areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
		spawntoporside = randi_range(1, 2)
			# Left and Right
		if spawntoporside == 1 : # (left/right)
			posornegproceduralx = randi_range(1, 2)
			posornegproceduraly = randi_range(1, 2)
			if posornegproceduralx == 1 :
				randoutsideofviewx = randf_range(0, 325)
			elif posornegproceduralx == 2 :
				randoutsideofviewx = randf_range(0, -325)
			if posornegproceduraly == 1 :
				randoutsideofviewy = randf_range(0, 350)
			elif posornegproceduraly == 2 :
				randoutsideofviewy = randf_range(-0, -350)
		if spawntoporside == 2 : # (top/bottom)
			posornegproceduralx = randi_range(1, 2)
			posornegproceduraly = randi_range(1, 2)
			if posornegproceduralx == 1 :
				randoutsideofviewx = randf_range(0, 325)
			elif posornegproceduralx == 2 :
				randoutsideofviewx = randf_range(-0, -325)
			if posornegproceduraly == 1 :
				randoutsideofviewy = randf_range(0, 225)
			elif posornegproceduraly == 2 :
				randoutsideofviewy = randf_range(0, -225)
			
			# Shipment :
			shipmentchance = randi_range(1, 600)
		
		if asteroidcount <= 35 :
			var new_asteroid1 = preload("res://Survivor Arcade Game/Scenes/asteroids.tscn").instantiate()
			new_asteroid1.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
			new_asteroid1.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
			get_node("/root/Game/Pickups").call_deferred("add_child",new_asteroid1)
		
	elif asteroidcount <= 20 and pocketedition == true :
		randomize()
		# Spawning :
		areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
		areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
		spawntoporside = randi_range(1, 2)
			# Left and Right
		if spawntoporside == 1 : # (left/right)
			posornegproceduralx = randi_range(1, 2)
			posornegproceduraly = randi_range(1, 2)
			if posornegproceduralx == 1 :
				randoutsideofviewx = randf_range(0, 325)
			elif posornegproceduralx == 2 :
				randoutsideofviewx = randf_range(0, -325)
			if posornegproceduraly == 1 :
				randoutsideofviewy = randf_range(0, 350)
			elif posornegproceduraly == 2 :
				randoutsideofviewy = randf_range(-0, -350)
		if spawntoporside == 2 : # (top/bottom)
			posornegproceduralx = randi_range(1, 2)
			posornegproceduraly = randi_range(1, 2)
			if posornegproceduralx == 1 :
				randoutsideofviewx = randf_range(0, 325)
			elif posornegproceduralx == 2 :
				randoutsideofviewx = randf_range(-0, -325)
			if posornegproceduraly == 1 :
				randoutsideofviewy = randf_range(0, 225)
			elif posornegproceduraly == 2 :
				randoutsideofviewy = randf_range(0, -225)
			
			# Shipment :
			shipmentchance = randi_range(1, 600)
		
		if asteroidcount <= 20 :
			var new_asteroid1 = preload("res://Survivor Arcade Game/Scenes/asteroids.tscn").instantiate()
			new_asteroid1.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
			new_asteroid1.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
			get_node("/root/Game/Pickups").call_deferred("add_child",new_asteroid1)
	for i in range(1) :
		if backgroundasteroidcount <= 70 and pocketedition == false :
			randomize()
			# Spawning :
			areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
			areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
			spawntoporside = randi_range(1, 2)
				# Left and Right
			if spawntoporside == 1 : # (left/right)
				posornegproceduralx = randi_range(1, 2)
				posornegproceduraly = randi_range(1, 2)
				if posornegproceduralx == 1 :
					randoutsideofviewx = randf_range(0, 345)
				elif posornegproceduralx == 2 :
					randoutsideofviewx = randf_range(0, -345)
				if posornegproceduraly == 1 :
					randoutsideofviewy = randf_range(0, 375)
				elif posornegproceduraly == 2 :
					randoutsideofviewy = randf_range(0, -375)
			if spawntoporside == 2 : # (top/bottom)
				posornegproceduralx = randi_range(1, 2)
				posornegproceduraly = randi_range(1, 2)
				if posornegproceduralx == 1 :
					randoutsideofviewx = randf_range(0, 345)
				elif posornegproceduralx == 2 :
					randoutsideofviewx = randf_range(0, -345)
				if posornegproceduraly == 1 :
					randoutsideofviewy = randf_range(0, 220)
				elif posornegproceduraly == 2 :
					randoutsideofviewy = randf_range(0, -220)
			var new_backgroundasteroid = preload("res://Survivor Arcade Game/Scenes/background.tscn").instantiate()
			new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
			new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
			randomize()
			var foreormid = randi_range(1, 8)
			if foreormid == 1 :
				get_node("/root/Game/Foreground").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 2 :
				get_node("/root/Game/Foreground2").call_deferred("add_child",new_backgroundasteroid)
			if foreormid == 3 :
				get_node("/root/Game/Foreground3").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 4 :
				get_node("/root/Game/Foreground4").call_deferred("add_child",new_backgroundasteroid)
			if foreormid == 5 :
				get_node("/root/Game/Foreground5").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 6 :
				get_node("/root/Game/Foreground6").call_deferred("add_child",new_backgroundasteroid)
			if foreormid == 7 :
				get_node("/root/Game/Foreground7").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 8 :
				get_node("/root/Game/Foreground8").call_deferred("add_child",new_backgroundasteroid)
			
		if backgroundasteroidcount <= 10 and pocketedition == true : 
			randomize()
			# Spawning :
			areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
			areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
			spawntoporside = randi_range(1, 2)
				# Left and Right
			if spawntoporside == 1 : # (left/right)
				posornegproceduralx = randi_range(1, 2)
				posornegproceduraly = randi_range(1, 2)
				if posornegproceduralx == 1 :
					randoutsideofviewx = randf_range(0, 345) / 1.5
				elif posornegproceduralx == 2 :
					randoutsideofviewx = randf_range(0, -345) / 1.5
				if posornegproceduraly == 1 :
					randoutsideofviewy = randf_range(0, 375) / 1.5
				elif posornegproceduraly == 2 :
					randoutsideofviewy = randf_range(0, -375) / 1.5
			if spawntoporside == 2 : # (top/bottom)
				posornegproceduralx = randi_range(1, 2)
				posornegproceduraly = randi_range(1, 2)
				if posornegproceduralx == 1 :
					randoutsideofviewx = randf_range(0, 345) / 1.5
				elif posornegproceduralx == 2 :
					randoutsideofviewx = randf_range(0, -345) / 1.5
				if posornegproceduraly == 1 :
					randoutsideofviewy = randf_range(0, 220) / 1.5
				elif posornegproceduraly == 2 :
					randoutsideofviewy = randf_range(0, -220) / 1.5
			var new_backgroundasteroid = preload("res://Survivor Arcade Game/Scenes/background.tscn").instantiate()
			new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
			new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
			randomize()
			var foreormid = randi_range(1, 8)
			if foreormid == 1 :
				get_node("/root/Game/Foreground").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 2 :
				get_node("/root/Game/Foreground2").call_deferred("add_child",new_backgroundasteroid)
			if foreormid == 3 :
				get_node("/root/Game/Foreground3").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 4 :
				get_node("/root/Game/Foreground4").call_deferred("add_child",new_backgroundasteroid)
			if foreormid == 5 :
				get_node("/root/Game/Foreground5").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 6 :
				get_node("/root/Game/Foreground6").call_deferred("add_child",new_backgroundasteroid)
			if foreormid == 7 :
				get_node("/root/Game/Foreground7").call_deferred("add_child",new_backgroundasteroid) 
			elif foreormid == 8 :
				get_node("/root/Game/Foreground8").call_deferred("add_child",new_backgroundasteroid)

func _on_proceduraltimer_timeout() :
	procedurally_spawn()

func procedurally_spawn() :
		randomize()
		for i in range(2) :
			randomize()
			# Spawning :
			areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
			areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
			spawntoporside = randi_range(1, 2)
				# Left and Right
			if spawntoporside == 1 : # (left/right)
				posornegproceduralx = randi_range(1, 2)
				posornegproceduraly = randi_range(1, 2)
				if posornegproceduralx == 1 :
					randoutsideofviewx = randf_range(275, 450)
				elif posornegproceduralx == 2 :
					randoutsideofviewx = randf_range(-275, -450)
				if posornegproceduraly == 1 :
					randoutsideofviewy = randf_range(0, 300)
				elif posornegproceduraly == 2 :
					randoutsideofviewy = randf_range(-0, -300)
			if spawntoporside == 2 : # (top/bottom)
				posornegproceduralx = randi_range(1, 2)
				posornegproceduraly = randi_range(1, 2)
				if posornegproceduralx == 1 :
					randoutsideofviewx = randf_range(0, 275)
				elif posornegproceduralx == 2 :
					randoutsideofviewx = randf_range(-0, -275)
				if posornegproceduraly == 1 :
					randoutsideofviewy = randf_range(175, 300)
				elif posornegproceduraly == 2 :
					randoutsideofviewy = randf_range(-175, -300)
				
			if pocketedition == false and asteroidcount <= 110 :
				var new_asteroid1 = preload("res://Survivor Arcade Game/Scenes/asteroids.tscn").instantiate()
				new_asteroid1.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
				new_asteroid1.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
				get_node("/root/Game/Pickups").call_deferred("add_child",new_asteroid1)
			elif pocketedition == true and asteroidcount <= 45 :
				var new_asteroid1 = preload("res://Survivor Arcade Game/Scenes/asteroids.tscn").instantiate()
				new_asteroid1.global_position.x = areax + %PlayerCharacter.global_position.x + ( randoutsideofviewx / 2 )
				new_asteroid1.global_position.y = areay + %PlayerCharacter.global_position.y + ( randoutsideofviewy / 2 )
				get_node("/root/Game/Pickups").call_deferred("add_child",new_asteroid1)
		for i in range(15) :
			if backgroundasteroidcount <= 700 and pocketedition == false :
				randomize()
				# Spawning :
				areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
				areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
				spawntoporside = randi_range(1, 2)
					# Left and Right
				if spawntoporside == 1 : # (left/right)
					posornegproceduralx = randi_range(1, 2)
					posornegproceduraly = randi_range(1, 2)
					if posornegproceduralx == 1 :
						randoutsideofviewx = randf_range(345, 355) # 425 before
					elif posornegproceduralx == 2 :
						randoutsideofviewx = randf_range(-345, -355) # -425 before
					if posornegproceduraly == 1 :
						randoutsideofviewy = randf_range(0, 375)
					elif posornegproceduraly == 2 :
						randoutsideofviewy = randf_range(-0, -375)
				if spawntoporside == 2 : # (top/bottom)
					posornegproceduralx = randi_range(1, 2)
					posornegproceduraly = randi_range(1, 2)
					if posornegproceduralx == 1 :
						randoutsideofviewx = randf_range(0, 345)
					elif posornegproceduralx == 2 :
						randoutsideofviewx = randf_range(-0, -345)
					if posornegproceduraly == 1 :
						randoutsideofviewy = randf_range(210, 220) # 280 before
					elif posornegproceduraly == 2 :
						randoutsideofviewy = randf_range(-210, -220) # -280 before
				var new_backgroundasteroid = preload("res://Survivor Arcade Game/Scenes/background.tscn").instantiate()
				new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
				new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
				var foreormid = randi_range(1, 8)
				if foreormid == 1 :
					get_node("/root/Game/Foreground").call_deferred("add_child",new_backgroundasteroid)
				elif foreormid == 2 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 6/5
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 8/7
					get_node("/root/Game/Foreground2").call_deferred("add_child",new_backgroundasteroid)
				if foreormid == 3 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/14
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/15
					get_node("/root/Game/Foreground3").call_deferred("add_child",new_backgroundasteroid) 
				elif foreormid == 4 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/11.5
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/11.5
					get_node("/root/Game/Foreground4").call_deferred("add_child",new_backgroundasteroid)
				if foreormid == 5 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/9
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/10
					get_node("/root/Game/Foreground5").call_deferred("add_child",new_backgroundasteroid) 
				elif foreormid == 6 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/6.5
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/6.5
					get_node("/root/Game/Foreground6").call_deferred("add_child",new_backgroundasteroid)
				if foreormid == 7 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/3.95
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/4.15
					get_node("/root/Game/Foreground7").call_deferred("add_child",new_backgroundasteroid) 
				elif foreormid == 8 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/1.375
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/1.5175
					get_node("/root/Game/Foreground8").call_deferred("add_child",new_backgroundasteroid)
			elif backgroundasteroidcount <= 50 and pocketedition == true :
				randomize()
				# Spawning :
				areax = randi_range(%proceduralspawnshape.position.x, %proceduralspawnshape.position.x + %proceduralspawnshape.get_shape().size.x)
				areay = randi_range(%proceduralspawnshape.position.y, %proceduralspawnshape.position.y + %proceduralspawnshape.get_shape().size.y)
				spawntoporside = randi_range(1, 2)
					# Left and Right
				if spawntoporside == 1 : # (left/right)
					posornegproceduralx = randi_range(1, 2)
					posornegproceduraly = randi_range(1, 2)
					if posornegproceduralx == 1 :
						randoutsideofviewx = randf_range(345, 355) / 1.5 # 425 before
					elif posornegproceduralx == 2 :
						randoutsideofviewx = randf_range(-345, -355) / 1.5 # -425 before
					if posornegproceduraly == 1 :
						randoutsideofviewy = randf_range(0, 375) / 1.5
					elif posornegproceduraly == 2 :
						randoutsideofviewy = randf_range(-0, -375) / 1.5
				if spawntoporside == 2 : # (top/bottom)
					posornegproceduralx = randi_range(1, 2)
					posornegproceduraly = randi_range(1, 2)
					if posornegproceduralx == 1 :
						randoutsideofviewx = randf_range(0, 345) / 1.5
					elif posornegproceduralx == 2 :
						randoutsideofviewx = randf_range(-0, -345) / 1.5
					if posornegproceduraly == 1 :
						randoutsideofviewy = randf_range(210, 220) / 1.5 # 280 before
					elif posornegproceduraly == 2 :
						randoutsideofviewy = randf_range(-210, -220) / 1.5 # -280 before
				var new_backgroundasteroid = preload("res://Survivor Arcade Game/Scenes/background.tscn").instantiate()
				new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
				new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
				var foreormid = randi_range(1, 8)
				if foreormid == 1 :
					get_node("/root/Game/Foreground").call_deferred("add_child",new_backgroundasteroid)
				elif foreormid == 2 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 6/5
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 8/7
					get_node("/root/Game/Foreground2").call_deferred("add_child",new_backgroundasteroid)
				if foreormid == 3 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/14
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/15
					get_node("/root/Game/Foreground3").call_deferred("add_child",new_backgroundasteroid) 
				elif foreormid == 4 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/11.5
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/11.5
					get_node("/root/Game/Foreground4").call_deferred("add_child",new_backgroundasteroid)
				if foreormid == 5 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/9
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/10
					get_node("/root/Game/Foreground5").call_deferred("add_child",new_backgroundasteroid) 
				elif foreormid == 6 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/6.5
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/6.5
					get_node("/root/Game/Foreground6").call_deferred("add_child",new_backgroundasteroid)
				if foreormid == 7 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/3.95
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/4.15
					get_node("/root/Game/Foreground7").call_deferred("add_child",new_backgroundasteroid) 
				elif foreormid == 8 :
					new_backgroundasteroid.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx * 20/1.375
					new_backgroundasteroid.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy * 20/1.5175
					get_node("/root/Game/Foreground8").call_deferred("add_child",new_backgroundasteroid)
					
			# Shipment :
		if player.playerhealth <= 25 :
			randomize()
			shipmentchance = randi_range(1, 125)
		else :
			randomize()
			shipmentchance = randi_range(1, 500)
		if shipmentchance == 1 :
			spawn_shipment()

func _on_procedural_spawn_body_entered(_body) :
	asteroidcount += 1


func _on_procedural_spawn_body_exited(body) :
	if body.has_method("shipmentdestroyed") :
		shipmentcount -= 1
		body.queue_free()
	else :
		asteroidcount -= 1
		body.queue_free()
# Shipments

var shipmentcount = 0

func spawn_shipment() :
	randomize()
	var new_shipment = preload("res://Survivor Arcade Game/Scenes/shipments.tscn").instantiate()
	alienpath.progress_ratio = randf()
	new_shipment.global_position = alienpath.global_position			#new_shipment.global_position.x = areax + %PlayerCharacter.global_position.x + randoutsideofviewx
																	#new_shipment.global_position.y = areay + %PlayerCharacter.global_position.y + randoutsideofviewy
	get_node("/root/Game/Pickups").call_deferred("add_child",new_shipment)

# Spawn background passer (e.g. planets/ships etc) :
func spawnlevelbackgroundpasser() : # PLANET for level 1/2/3/4/5
	randomize()
	var levelpassable = preload("res://Survivor Arcade Game/Scenes/background_passers.tscn").instantiate()
	levelpassable.planet = true
	get_node("/root/Game").call_deferred("add_child",levelpassable)
	
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
# Heavy Weapons :
# For controlling currently equipped weapons on the left and right
var leftcurrentlyactive = "nothing"
var rightcurrentlyactive  = "nothing"
var noquickreloadcheat = false

# Heavy Missile
var lockonmissiles = 0
var leftorrightchance
var nomoreleftmissile = false
var nomorerightmissile = false

func add_lockonmissileL() :
	var left_lockonmissile = preload("res://Survivor Arcade Game/Scenes/lockonmissile_left.tscn").instantiate()
	if leftcurrentlyactive == "nothing" or leftcurrentlyactive == "missiler" :
		if leftcurrentlyactive == "nothing" :
			lockonmissiles += 1
		if noquickreloadcheat == true :
			left_lockonmissile.point1reloaded = false
			left_lockonmissile.point2reloaded = false
			left_lockonmissile.point3reloaded = false
			left_lockonmissile.point2abouttobereloaded = false
			left_lockonmissile.projectile1ready = false
			left_lockonmissile.projectile2ready = false
			left_lockonmissile.projectile3ready = false
		playerfixated.call_deferred("add_child", left_lockonmissile)
		left_lockonmissile.leftorright = "left"
		leftcurrentlyactive = "missiler"
		nomoreleftflamethrower = false
		nomoreleftwarhorn = false
		noquickreloadcheat = false
	# Dropping previous heavy weapon :
	elif leftcurrentlyactive == "flamethrower" :
		flamethrowers -= 1
		var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
		new_flamethrowerpickup.global_position.x = player.global_position.x - 10
		new_flamethrowerpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)
		new_flamethrowerpickup.stopfollowing = true
		leftcurrentlyactive = "nothing"
		nomoreleftflamethrower = true
		noquickreloadcheat = true
		new_flamethrowerpickup.dropanimationleft()
		await get_tree().create_timer(0.1).timeout
		add_lockonmissileL()
	elif leftcurrentlyactive == "warhorn" :
		warhorns -= 1
		var new_warhornpickup = preload("res://Survivor Arcade Game/Scenes/warhorn_pickup.tscn").instantiate()
		new_warhornpickup.global_position.x = player.global_position.x - 10
		new_warhornpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_warhornpickup)
		new_warhornpickup.stopfollowing = true
		leftcurrentlyactive = "nothing"
		nomoreleftwarhorn = true
		noquickreloadcheat = true
		new_warhornpickup.dropanimationleft()
		await get_tree().create_timer(0.1).timeout
		add_lockonmissileL()

func add_lockonmissileR() :
	var right_lockonmissile = preload("res://Survivor Arcade Game/Scenes/lockonmissile_right.tscn").instantiate()
	if rightcurrentlyactive == "nothing" or rightcurrentlyactive == "missiler" :
		if rightcurrentlyactive == "nothing" :
			lockonmissiles += 1
		if noquickreloadcheat == true :
			right_lockonmissile.point1reloaded = false
			right_lockonmissile.point2reloaded = false
			right_lockonmissile.point3reloaded = false
			right_lockonmissile.point2abouttobereloaded = false
			right_lockonmissile.projectile1ready = false
			right_lockonmissile.projectile2ready = false
			right_lockonmissile.projectile3ready = false
		playerfixated.call_deferred("add_child", right_lockonmissile)
		right_lockonmissile.leftorright = "right"
		rightcurrentlyactive = "missiler"
		nomorerightflamethrower = false
		nomorerightwarhorn = false
		noquickreloadcheat = false
	# Dropping previous heavy weapon :
	elif rightcurrentlyactive == "flamethrower" :
		flamethrowers -= 1
		var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
		new_flamethrowerpickup.global_position.x = player.global_position.x + 20
		new_flamethrowerpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)
		new_flamethrowerpickup.stopfollowing = true 
		rightcurrentlyactive = "nothing"
		nomorerightflamethrower = true
		noquickreloadcheat = true
		new_flamethrowerpickup.dropanimation()
		await get_tree().create_timer(0.1).timeout
		add_lockonmissileR()
	elif rightcurrentlyactive == "warhorn" :
		warhorns -= 1
		var new_warhornpickup = preload("res://Survivor Arcade Game/Scenes/warhorn_pickup.tscn").instantiate()
		new_warhornpickup.global_position.x = player.global_position.x + 20
		new_warhornpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_warhornpickup)
		new_warhornpickup.stopfollowing = true
		rightcurrentlyactive = "nothing"
		nomorerightwarhorn = true
		noquickreloadcheat = true
		new_warhornpickup.dropanimation()
		await get_tree().create_timer(0.1).timeout
		add_lockonmissileR()

# Heavy Flamethrower
var flamethrowerpickups = 0
var flamethrowers = 0
var flamethrowerleft = false
var flamethrowerright = false
var nomoreleftflamethrower = false
var nomorerightflamethrower = false

func add_flamethrowerL() :
	var left_flamethrower = preload("res://Survivor Arcade Game/Scenes/flamethrower.tscn").instantiate()
	if leftcurrentlyactive == "nothing" or leftcurrentlyactive == "flamethrower" :
		if leftcurrentlyactive == "nothing" :
			flamethrowers += 1
		if noquickreloadcheat == true :
			left_flamethrower.shootable = false
			left_flamethrower.lastflameshootable = false
		flamethrowerleft = true
		playerfixated.call_deferred("add_child", left_flamethrower)
		left_flamethrower.position.x -= 6.5
		left_flamethrower.position.y -= 5.5
		left_flamethrower.leftorright = "left"
		leftcurrentlyactive = "flamethrower"
		nomoreleftmissile = false
		nomoreleftwarhorn = false
		noquickreloadcheat = false
	# Dropping previous heavy weapon :
	elif leftcurrentlyactive == "missiler" :
		lockonmissiles -= 1
		var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
		new_heavyweaponpickup.global_position.x = player.global_position.x - 10
		new_heavyweaponpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
		new_heavyweaponpickup.stopfollowing = true
		leftcurrentlyactive = "nothing"
		nomoreleftmissile = true
		noquickreloadcheat = true
		new_heavyweaponpickup.dropanimationleft()
		await get_tree().create_timer(0.1).timeout
		add_flamethrowerL()
	elif leftcurrentlyactive == "warhorn" :
		warhorns -= 1
		var new_warhornpickup = preload("res://Survivor Arcade Game/Scenes/warhorn_pickup.tscn").instantiate()
		new_warhornpickup.global_position.x = player.global_position.x - 10
		new_warhornpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_warhornpickup)
		new_warhornpickup.stopfollowing = true
		leftcurrentlyactive = "nothing"
		nomoreleftwarhorn = true
		noquickreloadcheat = true
		new_warhornpickup.dropanimationleft()
		await get_tree().create_timer(0.1).timeout
		add_flamethrowerL()
		
func add_flamethrowerR() :
	var right_flamethrower = preload("res://Survivor Arcade Game/Scenes/flamethrower.tscn").instantiate()
	if rightcurrentlyactive == "nothing" or rightcurrentlyactive == "flamethrower" :
		if rightcurrentlyactive == "nothing" :
			flamethrowers += 1
		if noquickreloadcheat == true :
			right_flamethrower.shootable = false
			right_flamethrower.lastflameshootable = false
		flamethrowerright = true
		playerfixated.call_deferred("add_child", right_flamethrower)
		right_flamethrower.position.x -= -18.5
		right_flamethrower.position.y -= 5.5
		right_flamethrower.leftorright = "right"
		rightcurrentlyactive = "flamethrower"
		nomorerightmissile = false
		nomorerightwarhorn = false
		noquickreloadcheat = false
	# Dropping previous heavy weapon :
	elif rightcurrentlyactive == "missiler" :
		lockonmissiles -= 1
		var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
		new_heavyweaponpickup.global_position.x = player.global_position.x + 20
		new_heavyweaponpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
		new_heavyweaponpickup.stopfollowing = true
		rightcurrentlyactive = "nothing"
		nomorerightmissile = true
		noquickreloadcheat = true
		new_heavyweaponpickup.dropanimation()
		await get_tree().create_timer(0.1).timeout
		add_flamethrowerR()
	elif rightcurrentlyactive == "warhorn" :
		warhorns -= 1
		var new_warhornpickup = preload("res://Survivor Arcade Game/Scenes/warhorn_pickup.tscn").instantiate()
		new_warhornpickup.global_position.x = player.global_position.x + 20
		new_warhornpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_warhornpickup)
		new_warhornpickup.stopfollowing = true
		rightcurrentlyactive = "nothing"
		nomorerightwarhorn = true
		noquickreloadcheat = true
		new_warhornpickup.dropanimation()
		await get_tree().create_timer(0.1).timeout
		add_flamethrowerR()
	
	# Warhorn :
var warhornpickups = 0
var warhorns = 0
var warhornleft = false
var warhornright = false
var nomoreleftwarhorn = false
var nomorerightwarhorn = false

func add_warhornR() :
	var right_warhorn = preload("res://Survivor Arcade Game/Scenes/warhorn.tscn").instantiate()
	if rightcurrentlyactive == "nothing" :
		warhorns += 1
		warhornright = true
		playerfixated.call_deferred("add_child", right_warhorn)
		right_warhorn.position.x += 17.5
		right_warhorn.position.y -= 5
		right_warhorn.leftorright = "right"
		rightcurrentlyactive = "warhorn"
		nomorerightmissile = false
		nomorerightflamethrower = false
	# Dropping previous heavy weapon :
	elif rightcurrentlyactive == "missiler" :
		lockonmissiles -= 1
		var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
		new_heavyweaponpickup.global_position.x = player.global_position.x + 20
		new_heavyweaponpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
		new_heavyweaponpickup.stopfollowing = true
		rightcurrentlyactive = "nothing"
		nomorerightmissile = true
		new_heavyweaponpickup.dropanimation()
		await get_tree().create_timer(0.1).timeout
		add_warhornR()
	elif rightcurrentlyactive == "flamethrower" :
		flamethrowers -= 1
		var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
		new_flamethrowerpickup.global_position.x = player.global_position.x + 20
		new_flamethrowerpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)
		new_flamethrowerpickup.stopfollowing = true 
		rightcurrentlyactive = "nothing"
		nomorerightflamethrower = true
		new_flamethrowerpickup.dropanimation()
		await get_tree().create_timer(0.1).timeout
		add_warhornR()

func add_warhornL() :
	var left_warhorn = preload("res://Survivor Arcade Game/Scenes/warhorn.tscn").instantiate()
	if leftcurrentlyactive == "nothing" :
		warhorns += 1
		warhornleft = true
		playerfixated.call_deferred("add_child", left_warhorn)
		left_warhorn.position.x -= 17.5
		left_warhorn.position.y -= 5
		left_warhorn.rotation_degrees = -90
		left_warhorn.leftorright = "left"
		leftcurrentlyactive = "warhorn"
		nomoreleftmissile = false
		nomoreleftflamethrower = false
	# Dropping previous heavy weapon :
	elif leftcurrentlyactive == "missiler" :
		lockonmissiles -= 1
		var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
		new_heavyweaponpickup.global_position.x = player.global_position.x - 10
		new_heavyweaponpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
		new_heavyweaponpickup.stopfollowing = true
		leftcurrentlyactive = "nothing"
		nomoreleftmissile = true
		new_heavyweaponpickup.dropanimationleft()
		await get_tree().create_timer(0.1).timeout
		add_warhornL()
	elif leftcurrentlyactive == "flamethrower" :
		flamethrowers -= 1
		var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
		new_flamethrowerpickup.global_position.x = player.global_position.x - 10
		new_flamethrowerpickup.global_position.y = player.global_position.y
		get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)
		new_flamethrowerpickup.stopfollowing = true
		leftcurrentlyactive = "nothing"
		nomoreleftflamethrower = true
		new_flamethrowerpickup.dropanimationleft()
		await get_tree().create_timer(0.1).timeout
		add_warhornL()
##################################################################################################




##################################################################################################
# Player Death Paused Situations
func _on_player_character_playerhealth_depleted():
	%PlayerCamera.global_position = player.deathcameraposition
	Engine.time_scale = 0.5
	await get_tree().create_timer(2.5).timeout
	%GameOverAnimation.play("restarttext")
	await get_tree().create_timer(0.25).timeout
	%GameOverScreen.visible = true
	%eliminated.visible = true
	%pressboost.visible = true
	if pocketedition == false :
		player.get_node("UI/stats/statslayer").visible = false
	if pocketedition == true :
		player.get_node("UI/stats/statslayer/HealthBar").visible = false
		player.get_node("UI/stats/statslayer/SoulBar").visible = false
		player.get_node("UI/stats/statslayer/BoostBar").visible = false
		player.get_node("UI/stats/statslayer/LevelBorder").visible = false
		player.get_node("UI/stats/statslayer/CurrentLevel").visible = false
		player.get_node("UI/stats/statslayer/PocketEditionButtonContainer").visible = true
	get_tree().paused = true
##################################################################################################
# Level Changes
var level = 1

func _on_player_character_level_2() :
	spawnlevelbackgroundpasser()
	level = 2
	spawn_guggler()
	spawn_guggler()
	spawn_alien2()
	await get_tree().create_timer(0.25).timeout
	spawn_alien2()
	await get_tree().create_timer(0.55).timeout
	spawn_alien2()
	await get_tree().create_timer(0.25).timeout
	spawn_alien2()


func _on_player_character_level_3() :
	spawnlevelbackgroundpasser()
	level = 3
	spawn_alien3()
	await get_tree().create_timer(0.25).timeout
	spawn_alien3()
	await get_tree().create_timer(0.25).timeout
	spawn_alien3()
	await get_tree().create_timer(0.25).timeout
	spawn_alien3()


func _on_player_character_level_4() :
	spawnlevelbackgroundpasser()
	level = 4
	spawn_alien4()
	await get_tree().create_timer(0.25).timeout
	spawn_alien4()
	await get_tree().create_timer(0.4).timeout
	spawn_alien4()


func _on_player_character_level_5() :
	spawnlevelbackgroundpasser()
	level = 5

func _on_player_character_level_6() :
	level = 6
###################################################################################################

# WEATHER

func _on_weatherchance_timeout() :
	var weathertype = 0
	randomize()
	weatherchance = randi_range(1, 8)
	if weatherchance == 8 :
		weathertype	= randi_range(1,3) # 1 is sapce fog,  2 is black hole , 3 is meteor shower
		if weathertype == 1 :
			var largescalechance = randi_range (1, 3)
			if largescalechance == 1 :
				for i in range(8) :
					const SPACEFOG1 = preload("res://Survivor Arcade Game/Scenes/space_fog.tscn")
					var new_spacefog = SPACEFOG1.instantiate()
					get_node("/root/Game/Effects").call_deferred("add_child",new_spacefog)
					outsideplayerviewweatherpath.progress_ratio = randf()
					new_spacefog.global_position = outsideplayerviewweatherpath.global_position
			elif largescalechance == 2 :
				for i in range(8) :
					const SPACEFOG1 = preload("res://Survivor Arcade Game/Scenes/space_fog.tscn")
					var new_spacefog = SPACEFOG1.instantiate()
					get_node("/root/Game/Effects").call_deferred("add_child",new_spacefog)
					outsideplayerviewweatherpath.progress_ratio = randf()
					new_spacefog.global_position = outsideplayerviewweatherpath.global_position
				await get_tree().create_timer(7.5).timeout
				for i in range(8) :
					const SPACEFOG1 = preload("res://Survivor Arcade Game/Scenes/space_fog.tscn")
					var new_spacefog = SPACEFOG1.instantiate()
					get_node("/root/Game/Effects").call_deferred("add_child",new_spacefog)
					outsideplayerviewweatherpath.progress_ratio = randf()
					new_spacefog.global_position = outsideplayerviewweatherpath.global_position
			elif largescalechance == 3 :
				for i in range(8) :
					const SPACEFOG1 = preload("res://Survivor Arcade Game/Scenes/space_fog.tscn")
					var new_spacefog = SPACEFOG1.instantiate()
					get_node("/root/Game/Effects").call_deferred("add_child",new_spacefog)
					outsideplayerviewweatherpath.progress_ratio = randf()
					new_spacefog.global_position = outsideplayerviewweatherpath.global_position
				await get_tree().create_timer(7.5).timeout
				for i in range(8) :
					const SPACEFOG1 = preload("res://Survivor Arcade Game/Scenes/space_fog.tscn")
					var new_spacefog = SPACEFOG1.instantiate()
					get_node("/root/Game/Effects").call_deferred("add_child",new_spacefog)
					outsideplayerviewweatherpath.progress_ratio = randf()
					new_spacefog.global_position = outsideplayerviewweatherpath.global_position
				await get_tree().create_timer(7.5).timeout
				for i in range(8) :
					const SPACEFOG1 = preload("res://Survivor Arcade Game/Scenes/space_fog.tscn")
					var new_spacefog = SPACEFOG1.instantiate()
					get_node("/root/Game/Effects").call_deferred("add_child",new_spacefog)
					outsideplayerviewweatherpath.progress_ratio = randf()
					new_spacefog.global_position = outsideplayerviewweatherpath.global_position
				return
				
		if weathertype == 2 :
			const BLACKHOLEPOSITION = preload("res://Survivor Arcade Game/Scenes/black_hole.tscn")
			var new_blackhole = BLACKHOLEPOSITION.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_blackhole)
			weatherpath.progress_ratio = randf()
			new_blackhole.global_position = weatherpath.global_position
			return
		if weathertype == 3 :
			
			const meteorshower1 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower1 = meteorshower1.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower1)
			hammerpath.progress_ratio = randf()
			new_meteorshower1.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower2 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower2 = meteorshower2.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower2)
			hammerpath.progress_ratio = randf()
			new_meteorshower2.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower3 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower3 = meteorshower3.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower3)
			hammerpath.progress_ratio = randf()
			new_meteorshower3.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower4 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower4 = meteorshower4.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower4)
			hammerpath.progress_ratio = randf()
			new_meteorshower4.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower5 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower5 = meteorshower5.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower5)
			hammerpath.progress_ratio = randf()
			new_meteorshower5.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower6 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower6 = meteorshower6.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower6)
			hammerpath.progress_ratio = randf()
			new_meteorshower6.global_position = hammerpath.global_position
			await get_tree().create_timer(1).timeout
			const meteorshower7 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower7 = meteorshower7.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower7)
			hammerpath.progress_ratio = randf()
			new_meteorshower7.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower8 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower8 = meteorshower8.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower8)
			hammerpath.progress_ratio = randf()
			new_meteorshower8.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower9 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower9 = meteorshower9.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower9)
			hammerpath.progress_ratio = randf()
			new_meteorshower9.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower10 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower10 = meteorshower10.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower10)
			hammerpath.progress_ratio = randf()
			new_meteorshower10.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower11 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower11 = meteorshower11.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower11)
			hammerpath.progress_ratio = randf()
			new_meteorshower11.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower12 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower12 = meteorshower12.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower12)
			hammerpath.progress_ratio = randf()
			new_meteorshower12.global_position = hammerpath.global_position
			await get_tree().create_timer(1).timeout
			const meteorshower13 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower13 = meteorshower13.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower13)
			hammerpath.progress_ratio = randf()
			new_meteorshower13.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower14 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower14 = meteorshower14.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower14)
			hammerpath.progress_ratio = randf()
			new_meteorshower14.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower15 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower15 = meteorshower15.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower15)
			hammerpath.progress_ratio = randf()
			new_meteorshower15.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower16 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower16 = meteorshower16.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower16)
			hammerpath.progress_ratio = randf()
			new_meteorshower16.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower17 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower17 = meteorshower17.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower17)
			hammerpath.progress_ratio = randf()
			new_meteorshower17.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower18 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower18 = meteorshower18.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower18)
			hammerpath.progress_ratio = randf()
			new_meteorshower18.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower55 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower55 = meteorshower55.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower55)
			hammerpath.progress_ratio = randf()
			new_meteorshower55.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower56 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower56 = meteorshower56.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower56)
			hammerpath.progress_ratio = randf()
			new_meteorshower56.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower57 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower57 = meteorshower57.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower57)
			hammerpath.progress_ratio = randf()
			new_meteorshower57.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower58 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower58 = meteorshower58.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower58)
			hammerpath.progress_ratio = randf()
			new_meteorshower58.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower59 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower59 = meteorshower59.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower59)
			hammerpath.progress_ratio = randf()
			new_meteorshower59.global_position = hammerpath.global_position
			await get_tree().create_timer(3.5).timeout
			const meteorshower19 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower19 = meteorshower19.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower19)
			hammerpath.progress_ratio = randf()
			new_meteorshower19.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower20 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower20 = meteorshower20.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower20)
			hammerpath.progress_ratio = randf()
			new_meteorshower20.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower21 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower21 = meteorshower21.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower21)
			hammerpath.progress_ratio = randf()
			new_meteorshower21.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower22 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower22 = meteorshower22.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower22)
			hammerpath.progress_ratio = randf()
			new_meteorshower22.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower23 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower23 = meteorshower23.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower23)
			hammerpath.progress_ratio = randf()
			new_meteorshower23.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower24 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower24 = meteorshower24.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower24)
			hammerpath.progress_ratio = randf()
			new_meteorshower24.global_position = hammerpath.global_position
			await get_tree().create_timer(1).timeout
			const meteorshower25 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower25 = meteorshower25.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower25)
			hammerpath.progress_ratio = randf()
			new_meteorshower25.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower26 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower26 = meteorshower26.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower26)
			hammerpath.progress_ratio = randf()
			new_meteorshower26.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower27 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower27 = meteorshower27.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower27)
			hammerpath.progress_ratio = randf()
			new_meteorshower27.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower28 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower28 = meteorshower28.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower28)
			hammerpath.progress_ratio = randf()
			new_meteorshower28.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower29 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower29 = meteorshower29.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower29)
			hammerpath.progress_ratio = randf()
			new_meteorshower29.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower30 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower30 = meteorshower30.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower30)
			hammerpath.progress_ratio = randf()
			new_meteorshower30.global_position = hammerpath.global_position
			await get_tree().create_timer(1).timeout
			const meteorshower31 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower31 = meteorshower31.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower31)
			hammerpath.progress_ratio = randf()
			new_meteorshower31.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower32 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower32 = meteorshower32.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower32)
			hammerpath.progress_ratio = randf()
			new_meteorshower32.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower33 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower33 = meteorshower33.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower33)
			hammerpath.progress_ratio = randf()
			new_meteorshower33.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower34 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower34 = meteorshower34.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower34)
			hammerpath.progress_ratio = randf()
			new_meteorshower34.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower35 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower35 = meteorshower35.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower35)
			hammerpath.progress_ratio = randf()
			new_meteorshower35.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower36 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower36 = meteorshower36.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower36)
			hammerpath.progress_ratio = randf()
			new_meteorshower36.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower60 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower60 = meteorshower60.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower60)
			hammerpath.progress_ratio = randf()
			new_meteorshower60.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower61 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower61 = meteorshower61.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower61)
			hammerpath.progress_ratio = randf()
			new_meteorshower61.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower62 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower62 = meteorshower62.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower62)
			hammerpath.progress_ratio = randf()
			new_meteorshower62.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower63 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower63 = meteorshower63.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower63)
			hammerpath.progress_ratio = randf()
			new_meteorshower63.global_position = hammerpath.global_position
			await get_tree().create_timer(0.3).timeout
			const meteorshower64 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower64 = meteorshower64.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower64)
			hammerpath.progress_ratio = randf()
			new_meteorshower64.global_position = hammerpath.global_position
			await get_tree().create_timer(3.5).timeout
			const meteorshower37 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower37 = meteorshower37.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower37)
			hammerpath.progress_ratio = randf()
			new_meteorshower37.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower38 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower38 = meteorshower38.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower38)
			hammerpath.progress_ratio = randf()
			new_meteorshower38.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower39 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower39 = meteorshower39.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower39)
			hammerpath.progress_ratio = randf()
			new_meteorshower39.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower40 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower40 = meteorshower40.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower40)
			hammerpath.progress_ratio = randf()
			new_meteorshower40.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower41 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower41 = meteorshower41.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower41)
			hammerpath.progress_ratio = randf()
			new_meteorshower41.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower42 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower42 = meteorshower42.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower42)
			hammerpath.progress_ratio = randf()
			new_meteorshower42.global_position = hammerpath.global_position
			await get_tree().create_timer(1).timeout
			const meteorshower43 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower43 = meteorshower43.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower43)
			hammerpath.progress_ratio = randf()
			new_meteorshower43.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower44 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower44 = meteorshower44.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower44)
			hammerpath.progress_ratio = randf()
			new_meteorshower44.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower45 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower45 = meteorshower45.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower45)
			hammerpath.progress_ratio = randf()
			new_meteorshower45.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower46 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower46 = meteorshower46.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower46)
			hammerpath.progress_ratio = randf()
			new_meteorshower46.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower47 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower47 = meteorshower47.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower47)
			hammerpath.progress_ratio = randf()
			new_meteorshower47.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower48 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower48 = meteorshower48.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower48)
			hammerpath.progress_ratio = randf()
			new_meteorshower48.global_position = hammerpath.global_position
			await get_tree().create_timer(1).timeout
			const meteorshower49 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower49 = meteorshower49.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower49)
			hammerpath.progress_ratio = randf()
			new_meteorshower49.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower50 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower50 = meteorshower50.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower50)
			hammerpath.progress_ratio = randf()
			new_meteorshower50.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower51 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower51 = meteorshower51.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower51)
			hammerpath.progress_ratio = randf()
			new_meteorshower51.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower52 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower52 = meteorshower52.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower52)
			hammerpath.progress_ratio = randf()
			new_meteorshower52.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower53 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower53 = meteorshower53.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower53)
			hammerpath.progress_ratio = randf()
			new_meteorshower53.global_position = hammerpath.global_position
			await get_tree().create_timer(0.1).timeout
			const meteorshower54 = preload("res://Survivor Arcade Game/Scenes/meteor_shower.tscn")
			var new_meteorshower54 = meteorshower54.instantiate()
			get_node("/root/Game/Effects").call_deferred("add_child",new_meteorshower54)
			hammerpath.progress_ratio = randf()
			new_meteorshower54.global_position = hammerpath.global_position
			return

# Squad Regroup Animation :
func _on_squad_regroup_animation_animation_started(_SquadRegroupAnimation: StringName) :
	%Squad1.visible = true
	%Squad2.visible = true
	%Squad3.visible = true
	await get_tree().create_timer(10).timeout
	%VictoryScreen.visible = true
