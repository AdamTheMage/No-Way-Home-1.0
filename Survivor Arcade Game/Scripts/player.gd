extends CharacterBody2D

signal playerhealth_depleted
signal level2
signal level3

#General Constants
const DAMAGE_RATE = 5.0

# General Variables
var boost = false

var playerhealth = 100.0
var boost_recharge = 100.0

# Movement
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Mechanics
var friction = 44
var direction = Vector2.ZERO
var acceleration = 200
var max_speed = 50

# Steady Boost Speed Timers
func _on_steady_decrease_timeout() :
	max_speed -= 5
	if max_speed <= 55 :
		max_speed = 50
	else :
		await get_tree().create_timer(1).timeout
		_on_steady_decrease_timeout()
	
func _on_steady_increase_timeout() :
	if boost_recharge >= 2 :
		if Input.is_action_pressed("boost") :
			if max_speed <= 68 :
				max_speed += 10.4
				if max_speed <= 68:
					return
				else :
					max_speed = 70
	
# Healthpack Functionality
func _on_stats_healthpack() :
	boost_recharge = 100
	%HealthBar.value += 25

# Special Effects
func _on_hurt_box_player_rooted() :
	max_speed = 2
	acceleration = 1
	friction = 200
	print ("stuck")
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false#
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
		%Rooted.visible = false
	await get_tree().create_timer(0.25).timeout
	if boost == true and boost_recharge > 5 :
		print("free")
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false
	else :
		max_speed = 50
		acceleration = 200
		friction = 44
		%RootedAnimation.visible = false

#Boost Recharge Functionality

func _on_boost_recharge_slow_timeout() :
	if boost_recharge <= 5 :
		boost_recharge += 1
		
func _on_boost_recharge_fast_timeout() :
	if Input.is_action_just_pressed("boost") :
		%BoostRechargeFast.stop()
	
	else :
		if boost_recharge >= 5 :
			if boost_recharge < 100 :
				boost_recharge += 2
				if boost_recharge >= 100 :
					%BoostRechargeFast.stop() 

func get_input() :
	direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return direction.normalized()

func _physics_process(delta : float):
	player_movement(delta)
	
func player_movement(delta):
	direction = get_input()
		
	if Input.is_action_just_released("boost") :
		%BoostRechargeSlow.start()
		%BoostRechargeFast.start()
		
	if direction == Vector2.ZERO :
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else :
			velocity = Vector2.ZERO
	else: 
		velocity += (direction * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	# Boost System
	const DEPLETION_RATE = 49.0
	
	%BoostBar.value = boost_recharge
	if boost_recharge > 2 :
		if Input.is_action_just_pressed("boost"):
			_on_steady_increase_timeout()
			if Input.is_action_pressed("boost"):
				if boost_recharge > 0 :
					%SteadyIncrease.start()
				
	if Input.is_action_pressed("boost") :
		if boost_recharge > 2 :
			boost = true
			boost_recharge -= DEPLETION_RATE * delta
			velocity += direction * acceleration * delta
			velocity = velocity.limit_length(max_speed)
			# play boost increase animation
		else :
			boost = false
			_on_steady_decrease_timeout()
	
	if Input.is_action_just_released("boost") :
		boost = false
		%SteadyDecrease.start()
		# play boost slowdown animation
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
	
	# Normal Movement 
	if Input.is_action_pressed("move_left") :
		%Spaceship.rotation_degrees = 270
		
	if Input.is_action_pressed("move_right") :
		%Spaceship.rotation_degrees = 90
		
	if Input.is_action_pressed("move_up") :
		%Spaceship.rotation_degrees = 0
		
	if Input.is_action_pressed("move_down") :
		%Spaceship.rotation_degrees = 180
		
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right") :
		%Spaceship.rotation_degrees = 135
	
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left") :
		%Spaceship.rotation_degrees = 225
	
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right") :
		%Spaceship.rotation_degrees = 45
	
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left") :
		%Spaceship.rotation_degrees = 315

	if boost == true :
		%Spaceship.play("BoostSpeedup")
		
	elif boost == false and velocity.length() > 0 : # measures the decimal points of the velocity value calculated above
		%Spaceship.play("Speedup") 
		if velocity.length() == 0 :
			get_node("Spaceship").play("Slowdown")
			
	else:
		%Spaceship.play("Idle")

	# Damage to Player
	
	var colliding_mobs = %Spaceship/%HurtBox.get_overlapping_bodies()
	if colliding_mobs.size() > 0:
		playerhealth -= DAMAGE_RATE * colliding_mobs.size() * delta
		%HealthBar.value = playerhealth
		if playerhealth <= 0.0:
			playerhealth_depleted.emit()
	
######################################################################
# Status Effects 
# Electrattack [Alien2]
func play_zapped_label() :
	pass # This will play the label

func zapped() :
	playerhealth -= 6
	%HealthBar.value = playerhealth
	if playerhealth <= 0.0:
		playerhealth_depleted.emit()

# Draugal Damage
func take_draugaldamage() :
	playerhealth -= 8
	%HealthBar.value = playerhealth
	if playerhealth <= 0.0:
		playerhealth_depleted.emit()

######################################################################
# Level Switch Signals (to help get it to the root game script)
func _on_stats_level_2() :
	level2.emit()


func _on_stats_level_3() :
	level3.emit()
