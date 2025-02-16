extends CharacterBody2D

signal playerhealth_depleted
signal camerashake
signal gamepaused
signal level2
signal level3
signal level4
signal level5
signal level6

#General Constants
const DAMAGE_RATE = 7.5

# General Variables
var deathcameraposition 
var playerdeaded = false
var boost = false
var pocketeditionboosting = false
var pressedcooldownR = false
var pressedcooldownL = false
var physicaldamage = false
var elementaldamage = false
var isblackholed = false

var invulnerable = false
var souls = 0
var vignetteon = false
var previousvictoryopacity
var playerhealth = 100
var boost_recharge = 100.0

# Particles
var engineon = false

# Animation Change
var slowdownplayed = false
var endinganimation = false

# Movement
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Mechanics
# Rotation
var downclickone = false
var downclicktwo = false
var uturn = false
var recentlyturned = false
var movingbackwards = false
var basemoving = false
var initialrotation = 0.0
var rotationdegrees = 0.0
var rotatingright = false
var rotatingleft = false
var rotationspeedleft = 2.25
var rotationspeedright = 2.25
var rotationincrement = 0.75

# Travel
var friction = 44
var direction = Vector2.ZERO
var acceleration = 200
var max_speed = 55.5

# Knockback
var knockback = Vector2.ZERO
var lenknockback = false
var alien1knockback = false
var gugglerknockback = false
var alien3knockback = false
var alien4knockback = false

@onready var particleplayer = get_node("/root/Game/particleplayer")
 
func _ready() :
	if DisplayServer.is_touchscreen_available() :
		# Making menus attached to the player slightly bigger for Pocket Edition :
		%LenurcherBar.scale.x = 20.633
		%LenurcherBar.scale.y = 20.633
		%LenurcherBar.position.x = 775.461
		
		%HealthBar.scale.x = 33.398
		%HealthBar.scale.y = 33.398
		
		%SoulBar.scale.x = 14.642
		%SoulBar.scale.y = 14.642
		%SoulBar.position.x = 2215.343
		%SoulBar.position.y = 18.364
		
		%LevelBorder.position.x = 1581.477
		%LevelBorder.scale.x = 15
		%LevelBorder.scale.y = 15
		
		%CurrentLevel.scale.x = 12.392
		%CurrentLevel.scale.y = 12.392
		%CurrentLevel.position.x = 1705.941
		%CurrentLevel.position.y = 54.469
		
		%BoostBar.scale.x = 29.117
		%BoostBar.scale.y = 29.176
		%BoostBar.position.x = 3535.201
		%BoostBar.position.y = 14.816
		
		get_node("/root/Game/GameOverScreen/ColorRect/eliminated").scale.x = 23.859
		get_node("/root/Game/GameOverScreen/ColorRect/eliminated").scale.y = 27.095
		get_node("/root/Game/GameOverScreen/ColorRect/eliminated").position.x = 811.363
		get_node("/root/Game/GameOverScreen/ColorRect/eliminated").position.y = 6.84

		get_node("/root/Game/GameOverScreen/ColorRect/pressboost").scale.x = 15.906
		get_node("/root/Game/GameOverScreen/ColorRect/pressboost").scale.y = 18.063
		get_node("/root/Game/GameOverScreen/ColorRect/pressboost").position.x = 1962.86
		get_node("/root/Game/GameOverScreen/ColorRect/pressboost").position.y = 514.67
		
# Steady Boost Speed Timers
func _on_steady_decrease_timeout() :
	max_speed -= 5
	if max_speed <= 60 :
		max_speed = 55.5
	else :
		await get_tree().create_timer(1).timeout
		_on_steady_decrease_timeout()
	
func _on_steady_increase_timeout() :
	if playerdeaded == false :
		if boost_recharge >= 2 :
			if Input.is_action_pressed("boost") :
				if max_speed <= 68 :
					max_speed += 10.4
					if max_speed <= 68:
						return
					else :
						max_speed = 70

# Steady Rotate Timers

func _on_turning_right_speedup_timeout() :
	rotationspeedright += rotationincrement


func _on_turning_left_speedup_timeout() :
	rotationspeedleft += rotationincrement

# Healthpack Functionality
func _on_stats_healthpack() :
	boost_recharge = 100
	playerhealth += 30
	%HealthBar.value += 30

func _on_health_capper_timeout() :
	invulnerable = false
# Special Effects
func _on_hurt_box_player_rooted() :
	camerashake.emit()
	max_speed = 2
	acceleration = 1
	friction = 200
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false#
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
	else :
		max_speed = 55.5
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false

#Boost Recharge Functionality

func _on_boost_recharge_slow_timeout() :
	if boost_recharge <= 5 :
		boost_recharge += 1
		
func _on_boost_recharge_fast_timeout() :
	if Input.is_action_just_pressed("boost") :
		if get_node("/root/Game").pocketedition == true :
			%Spaceship.play("BoostSpeedup")
		%BoostRechargeFast.stop()
	
	else :
		if boost_recharge >= 5 :
			if boost_recharge < 100 :
				boost_recharge += 2
				if boost_recharge >= 100 :
					%BoostRechargeFast.stop() 

func get_input(delta) :
	if endinganimation == false :
		if recentlyturned == false :
			
			if Input.is_action_just_released("move_down") and downclickone == false :
				downclickone = true
				%UTurnTimer.start()
				
			if Input.is_action_just_pressed("move_down") and downclickone == true :
				movingbackwards = true
				downclickone = false
				downclicktwo = true
				initialrotation = %Spaceship.rotation
				recentlyturned = true
				rotationdegrees = 0.0
					
		if Input.is_action_pressed("move_down") :
			if get_node("/root/Game").pocketedition == true :
					%Spaceship.play("Constant")
			movingbackwards = true
			if Input.is_action_pressed("move_right") :
				direction = Vector2(0,1).rotated(-%Spaceship.rotation)
			if Input.is_action_pressed("move_left") :
				direction = Vector2(0,1).rotated(%Spaceship.rotation)
			else:
				direction = Vector2(0,1).rotated(%Spaceship.rotation)
				rotationdegrees = %Spaceship.rotation
				if rotationdegrees < initialrotation + 3.11667990685 and downclicktwo == true :
					if uturn == false : 
						%Spaceship.rotate(20 * delta)
				else :
					downclicktwo = false
					uturn = true
			max_speed = 32
			if Input.is_action_pressed("boost") :
				if get_node("/root/Game").pocketedition == true :
					%Spaceship.play("BoostSpeedup")
				direction = Vector2(0,-1).rotated(%Spaceship.rotation)
				max_speed = 40
			if Input.is_action_just_released("move_down") :
				downclicktwo = false
				uturn = true
				max_speed = 55.5
			return direction.normalized()
				
			
		if Input.is_action_just_released("move_down") :
			if Input.is_action_pressed("move_left") :
				# initialrotation = 180
				direction = Vector2(0,1).rotated(-%Spaceship.rotation)
			else :
				uturn = false
				direction = Vector2(0,1).rotated(%Spaceship.rotation)
			
			%BackwardsFinishTimer.start()
		
		if Input.is_action_pressed("move_up") :
			basemoving = true
			movingbackwards = false
			direction = Vector2(0,-1).rotated(%Spaceship.rotation)
			return direction.normalized()
		
		# JOYSTICK - for Pocket Edition
		elif %Joystick.posVector :
			direction = %Joystick.posVector
			%Spaceship.rotation = float(%Joystick.posVector.angle()) + 1.55 
			if %Joystick.posVector != Vector2.ZERO :
				if get_node("/root/Game").pocketedition == true and boost == false :
					slowdownplayed = false
					%Spaceship.play("Speedup")
				basemoving = true
			else :
				basemoving = false
			return direction.normalized()
		else :
			basemoving = false
			if get_node("/root/Game").pocketedition == true and velocity == Vector2.ZERO and slowdownplayed == false :
				slowdownplayed = true
				%Spaceship.play("Slowdown")
			direction = Vector2.ZERO
			return direction.normalized()
	else :
		direction = Vector2.ZERO

func _physics_process(delta : float): # ( Checks every Frame )
	# Checks that player has not gone over 100 health :
	player_movement(delta)
	if playerhealth > 100 :
		playerhealth = 100
	%HealthBar.value = playerhealth
	if boost_recharge > 100 :
		boost_recharge = 100
	%BoostBar.value = boost_recharge
	# Vignette
	if playerhealth <= 25 :
		vignetteon = true
		%Vignette.visible = true
		%Vignette.material.set("shader_parameter/Vignette_opacity" , (25 - playerhealth) * 0.04 )
	else :
		vignetteon = false
		%Vignette.visible = false
	if endinganimation == true :
		%Vignette.visible = false
		%VictoryVignette.visible = true
		previousvictoryopacity = %VictoryVignette.material.get("shader_parameter/Vignette_opacity")
		%VictoryVignette.material.set("shader_parameter/Vignette_opacity" , previousvictoryopacity + (0.25 * delta) )
	
func player_movement(delta):
	direction = get_input(delta)
	
	if Input.is_action_just_released("boost") :
		%BoostRechargeSlow.start()
		%BoostRechargeFast.start()
		
	if direction == Vector2.ZERO :
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta) 
		else :
			velocity = Vector2.ZERO
	else: 
		if endinganimation == false :
			velocity += ((direction - knockback) * acceleration * delta) 
			velocity = velocity.limit_length(max_speed)
		else :
			velocity = Vector2.ZERO
	# Boost System
	const DEPLETION_RATE = 49.0
	
	%BoostBar.value = boost_recharge
	if boost_recharge > 2 :
		if Input.is_action_just_pressed("boost"):
			if get_node("/root/Game").pocketedition == true :
				%Spaceship.play("BoostSpeedup")
			_on_steady_increase_timeout()
			if Input.is_action_pressed("boost"):
				if boost_recharge > 0 :
					%SteadyIncrease.start()
				
	if Input.is_action_pressed("boost") :
		movingbackwards = false
		if boost_recharge > 2 :
			direction = Vector2(0,-1).rotated(%Spaceship.rotation)
			boost = true
			boost_recharge -= DEPLETION_RATE * delta
			velocity += direction * acceleration * delta ########################################
			velocity = velocity.limit_length(max_speed)
		else :
			boost = false
			_on_steady_decrease_timeout()
	
	if Input.is_action_just_released("boost") :
		boost = false
		%SteadyDecrease.start()
		if get_node("/root/Game").pocketedition == true:
			%Spaceship.play("BoostSlowdown")
		%BoostRechargeFast.stop()
		await get_tree().create_timer(4).timeout
		%BoostRechargeFast.start()
			
	if boost_recharge <= 0 :
		%SteadyDecrease.start()
		if boost_recharge <= 100 :
			%BoostRechargeFast.start()
	
	move_and_slide()
	
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	# Directional Sprite Rotation :
	if Input.is_action_pressed("freestyle") :
		%Spaceship.rotate(270)
	
	# Right
	if Input.is_action_just_pressed("move_right") :
		%TurningRightSpeedup.start()
	if Input.is_action_pressed("move_right") :
		rotatingright = true
		%Spaceship.rotate(rotationspeedright * delta)
		if rotationspeedright >= 6.5 :
			%TurningRightSpeedup.stop()
		#%Spaceship.rotate(5 * delta)
	if Input.is_action_just_released("move_right") :
		rotatingright = false
		%TurningRightSpeedup.stop()
		#await get_tree().create_timer(0.2).timeout
		if rotatingright == false :
			rotationspeedright = 1.75

	# Left
	if Input.is_action_just_pressed("move_left") :
		%TurningLeftSpeedup.start()
	if Input.is_action_pressed("move_left") :
		rotatingleft = true
		%Spaceship.rotate(-rotationspeedleft * delta)
		if rotationspeedleft >= 6.5 :
			%TurningLeftSpeedup.stop()
	if Input.is_action_just_released("move_left") :
		rotatingleft = false
		%TurningLeftSpeedup.stop()
		#await get_tree().create_timer(0.2).timeout
	if rotatingleft == false :
			rotationspeedleft = 1.75
	else:
		%Spaceship.play("Idle")

	# Damage to Player
	
	var colliding_mobs = %Spaceship/%HurtBox.get_overlapping_bodies()
	if colliding_mobs.size() > 0 :
		# Particles off Spaceship
		if get_node("/root/Game").pocketedition == false :
			const SPACESHIP_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var spaceshipbits = SPACESHIP_PARTICLES.instantiate()
			spaceshipbits.spaceship_collision_particles()
			get_node("/root/Game/particleplayer").call_deferred("add_child", spaceshipbits)
			spaceshipbits.global_position = global_position 
			spaceshipbits.global_rotation = global_rotation 
		#
		physicaldamage = true
		if invulnerable == false :
			playerhealth -= DAMAGE_RATE * colliding_mobs.size() * delta
			%HealthBar.value = playerhealth
			if playerhealth <= 0.0:
				playerdead()
	if colliding_mobs.size() == 0 :
		physicaldamage = false
#################################################################################################
# Pocket Edition Buttons :
func _on_boost_button_pressed() :
	Input.action_press("boost")
	boost = false
	%SteadyDecrease.start()
	%BoostRechargeFast.stop()
	await get_tree().create_timer(4).timeout
	%BoostRechargeFast.start()

func _on_boost_button_released() :
	Input.action_release("boost")
	%BoostRechargeSlow.start()
	%BoostRechargeFast.start()


func _on_fire_l_button_pressed() :
	Input.action_press("fire_left")

func _on_fire_l_button_released() :
	Input.action_release("fire_left")


func _on_fire_r_button_pressed() :
	Input.action_press("fire_right")


func _on_fire_r_button_released() :
	Input.action_release("fire_right")


# Movement Particles
func _on_boost_checker_timeout() :
	if get_node("/root/Game").pocketedition == false :
		if movingbackwards == true : 
			return
		if boost == true :
			const BOOST_PARTICLESL = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var boostparticlesL = BOOST_PARTICLESL.instantiate()
			boostparticlesL.spaceshipboost_particles()
			particleplayer.call_deferred("add_child", boostparticlesL)
			boostparticlesL.global_position = %engineL.global_position
			boostparticlesL.global_rotation = %engineL.global_rotation
			const BOOST_PARTICLESR = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var boostparticlesR = BOOST_PARTICLESR.instantiate()
			boostparticlesR.spaceshipboost_particles()
			particleplayer.call_deferred("add_child", boostparticlesR)
			boostparticlesR.global_position = %engineR.global_position
			boostparticlesR.global_rotation = %engineR.global_rotation
		if boost == false and basemoving == true : # measures the decimal points of the velocity value calculated above
			engineon = true
			const MOVE_PARTICLESL = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var moveparticlesL = MOVE_PARTICLESL.instantiate()
			moveparticlesL.spaceshipmove_particles()
			particleplayer.call_deferred("add_child", moveparticlesL)
			moveparticlesL.global_position = %engineL.global_position
			moveparticlesL.global_rotation = %engineL.global_rotation
			const move_PARTICLESR = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var moveparticlesR = move_PARTICLESR.instantiate()
			moveparticlesR.spaceshipmove_particles()
			particleplayer.call_deferred("add_child", moveparticlesR)
			moveparticlesR.global_position = %engineR.global_position
			moveparticlesR.global_rotation = %engineR.global_rotation 
			return
		if engineon == true and boost == false:
			for i in range (4) :
				if engineon == true and boost == false :
					await get_tree().create_timer(0.45).timeout
					const MOVE_PARTICLESL = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
					var moveparticlesL = MOVE_PARTICLESL.instantiate()
					moveparticlesL.spaceshipmove_particles()
					particleplayer.call_deferred("add_child", moveparticlesL)
					moveparticlesL.global_position = %engineL.global_position
					moveparticlesL.global_rotation = %engineL.global_rotation
					const move_PARTICLESR = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
					var moveparticlesR = move_PARTICLESR.instantiate()
					moveparticlesR.spaceshipmove_particles()
					particleplayer.call_deferred("add_child", moveparticlesR)
					moveparticlesR.global_position = %engineR.global_position
					moveparticlesR.global_rotation = %engineR.global_rotation 
				else : return
			engineon = false
######################################################################
# Status Effects 
# Weather
	# Black Hole
func blackholed () :
	elementaldamage = true
	camerashake.emit()
	%statuseffects.visible = true
	%statuseffects.play("Crushed")
	isblackholed = true
	await get_tree().create_timer(0.05).timeout
	const BLACKHOLEPOSITION = preload("res://Survivor Arcade Game/Scenes/black_hole.tscn")
	var new_blackhole = BLACKHOLEPOSITION.instantiate()
	get_node("/root/Game/Effects").call_deferred("add_child",new_blackhole)
	new_blackhole.global_position = global_position
	await get_tree().create_timer(3).timeout
	%statuseffects.visible = false
	elementaldamage = false
	await get_tree().create_timer(5).timeout
	isblackholed = false
	
	# Meteored
func meteored () :
	if invulnerable == false :
		camerashake.emit()
		playerhealth -= 14
		rotationspeedleft = 2
		rotationspeedright = 2
		elementaldamage = true
		%statuseffects.visible = true
		%Crushed.visible = true
		%crushedplayer.play("crushed")
		%statuseffects.play("Crushed")
		invulnerable = true
		await get_tree().create_timer(2).timeout
		elementaldamage = false
		%statuseffects.visible = false
	
# Crushed
func play_crushed() :
	camerashake.emit()
	rotationspeedleft = 2
	rotationspeedright = 2
	elementaldamage = true
	%statuseffects.visible = true
	%Crushed.visible = true
	%crushedplayer.play("crushed")
	%statuseffects.play("Shocked")
	invulnerable = true
	await get_tree().create_timer(2).timeout
	elementaldamage = false
	%statuseffects.visible = false

# Electrattack [Alien2]
func play_zapped_label() :
	pass # This will play the label

func zapped() :
	if invulnerable == false :
		camerashake.emit()
		rotationspeedleft = 2
		rotationspeedright = 2
		elementaldamage = true
		%statuseffects.visible = true
		%statuseffects.play("Shocked")
		playerhealth -= 9
		%HealthBar.value = playerhealth
		if playerhealth <= 0.0:
			playerdead()
		invulnerable = true
		await get_tree().create_timer(2).timeout
		elementaldamage = false
		%statuseffects.visible = false
# Draugal Damage
func take_draugaldamage() :
	if invulnerable == false :
		elementaldamage = true
		%statuseffects.visible = true
		%statuseffects.play("Corrupted")
		playerhealth -= 8
		%HealthBar.value = playerhealth
		if playerhealth <= 0.0:
			playerdead()
		invulnerable = true
		await get_tree().create_timer(2).timeout
		elementaldamage = false
		%statuseffects.visible = false

# Guggler Damage
func take_gugglerspewdamage() :
	if invulnerable == false :
		camerashake.emit()
		elementaldamage = true
		%statuseffects.visible = true
		%statuseffects.play("Corrupted")
		playerhealth -= 16
		%HealthBar.value = playerhealth
		if playerhealth <= 0.0:
			playerdead()
		invulnerable = true
		await get_tree().create_timer(2).timeout
		elementaldamage = false
		%statuseffects.visible = false

# Lenurcher Damage

func take_bluehell_damage() :
	if invulnerable == false :
		camerashake.emit()
		elementaldamage = true
		%statuseffects.visible = true
		%statuseffects.play("Shocked")
		playerhealth -= 16
		%HealthBar.value = playerhealth
		if playerhealth <= 0.0:
			playerdead()
		invulnerable = true
		await get_tree().create_timer(2).timeout
		elementaldamage = false
		%statuseffects.visible = false
		
func take_lightninghellfire_damage() :
	if invulnerable == false :
		rotationspeedleft = 2
		rotationspeedright = 2
		elementaldamage = true
		%statuseffects.visible = true
		%statuseffects.play("Shocked")
		playerhealth -= 8
		%HealthBar.value = playerhealth
		if playerhealth <= 0.0:
			playerdead()
		invulnerable = true
		await get_tree().create_timer(2).timeout
		elementaldamage = false
		%statuseffects.visible = false

######################################################################
# RECEIVING SOULS
func soulmagnet() :
	# lets us know if it can attract the magnet
	pass

func soulreceive1() :
	souls += 1
	playerhealth += 2
	boost_recharge += 5
func soulreceive2() :
	souls += 1
	playerhealth += 3
	boost_recharge += 5
	#playerhealth += 2
	
func soulreceive5() :
	souls += 1
	playerhealth += 5
	boost_recharge += 5
	#playerhealth += 5

func soulreceivelenurcher() :
	souls += 20
	playerhealth += 25
	boost_recharge += 5
	#playerhealth += 15
	

# Level Switch Signals (to help get it to the root game script)
func _on_stats_level_2() :
	level2.emit()


func _on_stats_level_3() :
	level3.emit()


func _on_stats_level_4() :
	level4.emit()
	pass


func _on_stats_level_5() :
	level5.emit()
	pass


func _on_stats_level_6() :
	level6.emit()
	pass

func _on_backwards_finish_timer_timeout() :
	if Input.is_action_pressed("move_down") :
		if Input.is_action_pressed("move_left") :
			# initialrotation = 180
			direction = Vector2(0,1).rotated(-%Spaceship.rotation)
	else :
		uturn = false
		recentlyturned = false
		direction = Vector2.ZERO
	
func _on_appearancechecker_timeout() :
	if elementaldamage == false :
		if physicaldamage == true :
			%statuseffects.visible = true
			%statuseffects.play("Physicaldamage")
		if physicaldamage == false :
			%statuseffects.visible = false
	else : 
		pass


func _on_hurt_box_body_entered(body) :
	# Knockback :
	var knockbackx
	var knockbacky
	
	# Lenurcher : 
	if body.has_method("lenurcher_knockback") :
		lenknockback = true
		%KnockBackChecker.start()
		knockbackx = -($".".global_position.x -body.global_position.x) * 0.5
		knockbacky = -($".".global_position.y -body.global_position.y) * 0.5
		knockback = Vector2(knockbackx, knockbacky)
	
	# alien1 :
	if body.has_method("alien1_knockback") :
		alien1knockback = true
		%KnockBackChecker.start()
		knockbackx = -($".".global_position.x -body.global_position.x) * 0.1
		knockbacky = -($".".global_position.y -body.global_position.y) * 0.1
		knockback = Vector2(knockbackx, knockbacky)
	
	# guggler :
	if body.has_method("guggler_knockback") :
		gugglerknockback = true
		%KnockBackChecker.start()
		knockbackx = -($".".global_position.x -body.global_position.x) * 0.25
		knockbacky = -($".".global_position.y -body.global_position.y) * 0.25
		knockback = Vector2(knockbackx, knockbacky)
	
	# alien2 :
	# No Knockback Needed

	# alien3 :
	if body.has_method("alien3_knockback") :
		alien3knockback = true
		%KnockBackChecker.start()
		knockbackx = -($".".global_position.x -body.global_position.x) * 0.05
		knockbacky = -($".".global_position.y -body.global_position.y) * 0.05
		knockback = Vector2(knockbackx, knockbacky)

	# alien4 : 
	if body.has_method("alien4_knockback") :
		alien4knockback = true
		%KnockBackChecker.start()
		knockbackx = -($".".global_position.x -body.global_position.x) * 0.6
		knockbacky = -($".".global_position.y -body.global_position.y) * 0.6
		knockback = Vector2(knockbackx, knockbacky)

func playerknocksaround () :
	# Helps us define the characters (via get method) in the game that can knock other bodies around
	pass

func _on_knock_back_checker_timeout() :
	if boost == true :
		knockback = Vector2.ZERO
		
	if lenknockback == true :
		await get_tree().create_timer(1.05).timeout
		knockback = Vector2.ZERO
		
	if alien1knockback == true :
		await get_tree().create_timer(0.05).timeout
		knockback = Vector2.ZERO
		
	if gugglerknockback == true :
		await get_tree().create_timer(0.05).timeout
		knockback = Vector2.ZERO
		
	if alien3knockback == true :
		knockback = Vector2.ZERO
		
	if alien4knockback == true :
		await get_tree().create_timer(0.6).timeout
		knockback = Vector2.ZERO


func _on_u_turn_timer_timeout() :
	downclickone = false
#################################################################################################

# DEATH
func playerdead() :
	deathcameraposition = $".".global_position
	%DyingSpin.start()
	playerdeaded = true
	playerhealth_depleted.emit()
	const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke = SMOKE_EFFECT.instantiate()
	smoke.scale.x = -0.175
	smoke.scale.y = -0.175
	add_child(smoke)
	smoke.global_position = global_position + Vector2 (2.5 , 0)
	smoke.global_rotation = global_rotation
	const SMOKE_EFFECT11 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke11 = SMOKE_EFFECT11.instantiate()
	smoke11.scale.x = -0.175
	smoke11.scale.y = -0.175
	add_child(smoke11)
	smoke11.global_position = global_position + Vector2 (-2.5 , 0)
	smoke11.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT2 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke2 = SMOKE_EFFECT2.instantiate()
	smoke2.scale.x = -0.175
	smoke2.scale.y = -0.175
	add_child(smoke2)
	smoke2.global_position = global_position + Vector2 (-2.5 , 0)
	smoke2.global_rotation = global_rotation
	const SMOKE_EFFECT22 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke22 = SMOKE_EFFECT22.instantiate()
	smoke22.scale.x = -0.175
	smoke22.scale.y = -0.175
	add_child(smoke22)
	smoke22.global_position = global_position + Vector2 (-1.5 , 2.5)
	smoke22.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT3 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke3 = SMOKE_EFFECT3.instantiate()
	smoke3.scale.x = -0.175
	smoke3.scale.y = -0.175
	add_child(smoke3)
	smoke3.global_position = global_position + Vector2 (-1.5 , 2.5)
	smoke3.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT4 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke4 = SMOKE_EFFECT4.instantiate()
	smoke4.scale.x = -0.175
	smoke4.scale.y = -0.175
	add_child(smoke4)
	smoke4.global_position = global_position + Vector2 (0 , -2)
	smoke4.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT5 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke5 = SMOKE_EFFECT5.instantiate()
	smoke5.scale.x = -0.175
	smoke5.scale.y = -0.175
	add_child(smoke5)
	smoke5.global_position = global_position + Vector2 (0 , 0.5)
	smoke5.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT6 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke6 = SMOKE_EFFECT6.instantiate()
	smoke6.scale.x = -0.175
	smoke6.scale.y = -0.175
	add_child(smoke6)
	smoke6.global_position = global_position + Vector2 (2.5 , 3)
	smoke6.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT7 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke7 = SMOKE_EFFECT7.instantiate()
	smoke7.scale.x = -0.175
	smoke7.scale.y = -0.175
	add_child(smoke7)
	smoke7.global_position = global_position + Vector2 (0.5 , -1)
	smoke7.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT8 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke8 = SMOKE_EFFECT8.instantiate()
	smoke8.scale.x = -0.175
	smoke8.scale.y = -0.175
	add_child(smoke8)
	smoke8.global_position = global_position + Vector2 (-2.5 , -3)
	smoke8.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout
	const SMOKE_EFFECT9 = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke9 = SMOKE_EFFECT9.instantiate()
	smoke9.scale.x = -0.175
	smoke9.scale.y = -0.175
	add_child(smoke9)
	smoke9.global_position = global_position + Vector2 (-0.5 , 1)
	smoke9.global_rotation = global_rotation
	await get_tree().create_timer(0.25).timeout

func _on_dying_spin_timeout() :
	%Spaceship.rotate(270)

#################################################################################################


func _on_gamepausedchecker_gamepaused() :
	if playerdeaded == false :
		%statslayer.visible = false
		$".".visible = false


func _on_gamepausedchecker_gameresumed() :
	%statslayer.visible = true
	$".".visible = true


func _on_level_up_area_kill_body_entered(body) :
	if body.has_method("aliendeath") :
		body.aliendeathnosoul()

#################################################################################################


func _on_pocket_edition_pause_pressed() :
	gamepaused.emit()

# Game Finished Animation - Squad Regroup :
func _on_squad_regroup_animation_animation_started(_squadregroup : StringName) :
	%LenurcherBar.visible = false
	%HealthBar.visible = false
	%SoulBar.visible = false
	%BoostBar.visible = false
	%LevelBorder.visible = false
	%CurrentLevel.visible = false
	endinganimation = true
	%CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(5).timeout
	%SquadRegroup.play("spaceshipturntoregroup")
