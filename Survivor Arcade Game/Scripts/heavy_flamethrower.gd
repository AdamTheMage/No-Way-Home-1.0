extends Area2D

var shootable = true
var lastflameshootable = true
var leftorright 

# Particles
var particlesleftbegin = false
var particlesrightbegin = false

var firstflame = false
var secondflame = false
var thirdflame = false

# const FLAMETHROWER_FLAME_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
@onready var flameparticles = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
@onready var Game = get_node("/root/Game")
@onready var particleplayer = get_node("/root/Game/particleplayer")

func _process(_delta) :
	if Input.is_action_just_pressed("fire_left") :
		if leftorright == "left" and shootable == true or firstflame == true and leftorright == "left" or secondflame == true and leftorright == "left" :
			flamethrow()
	elif Input.is_action_just_pressed("fire_right") :
		if leftorright == "right" and shootable == true or firstflame == true and leftorright == "right" or secondflame == true and leftorright == "right" :
			flamethrow()
	
	# Unequip :
	if Game.nomoreleftflamethrower == true and leftorright == "left" :
		print ("leftremoved")
		queue_free()
	elif Game.nomorerightflamethrower == true and leftorright == "right" :
		print ("rightremoved")
		queue_free() 

func _ready() :
	if leftorright == "left" :
		%Flamethrowerattachment.play("right")
	if leftorright == "right" :
		%Flamethrowerattachment.play("left")

func flamethrow():
	if firstflame == false :
		const FLAME = preload("res://Survivor Arcade Game/Scenes/flamethrower_flame.tscn")
		var new_flame = FLAME.instantiate()
		if leftorright == "left" :
			new_flame.global_position = %RightShootingPoint.global_position
			new_flame.global_rotation = %RightShootingPoint.global_rotation
		if leftorright == "right" :
			new_flame.global_position = %LeftShootingPoint.global_position
			new_flame.global_rotation = %LeftShootingPoint.global_rotation
		Game.call_deferred("add_child",new_flame)
		firstflame = true
		shootable = false
		%heavytimer.wait_time = 8.5
		%heavytimer.start()
		if leftorright == "right" :
			%Flamethrowerattachment.play("lefttwo")
		if leftorright == "left" :
			%Flamethrowerattachment.play("righttwo")
		return
	if secondflame == false and firstflame == true :
		const FLAME2 = preload("res://Survivor Arcade Game/Scenes/flamethrower_flame.tscn")
		var new_flame2 = FLAME2.instantiate()
		new_flame2.scale.x = 0.675
		new_flame2.scale.y = 0.675
		new_flame2.modulate = Color(1, 0.618, 0.266, 1)
		new_flame2.medium = true
		if leftorright == "left" :
			new_flame2.global_position = %RightShootingPoint.global_position
			new_flame2.global_rotation = %RightShootingPoint.global_rotation
		if leftorright == "right" :
			new_flame2.global_position = %LeftShootingPoint.global_position
			new_flame2.global_rotation = %LeftShootingPoint.global_rotation
		Game.call_deferred("add_child",new_flame2)
		secondflame = true
		%heavytimer.wait_time += 2
		%heavytimer.start()
		if leftorright == "right" :
			%Flamethrowerattachment.play("leftone")
		if leftorright == "left" :
			%Flamethrowerattachment.play("rightone")
		return
	if firstflame == true and secondflame == true and thirdflame == false :
		const FLAME3 = preload("res://Survivor Arcade Game/Scenes/flamethrower_flame.tscn")
		var new_flame3 = FLAME3.instantiate()
		new_flame3.scale.x = 0.5
		new_flame3.scale.y = 0.5
		new_flame3.modulate = Color(0.875, 0.418, 0, 1)
		new_flame3.smallest = true
		if leftorright == "left" :
			new_flame3.global_position = %RightShootingPoint.global_position
			new_flame3.global_rotation = %RightShootingPoint.global_rotation
		if leftorright == "right" :
			new_flame3.global_position = %LeftShootingPoint.global_position
			new_flame3.global_rotation = %LeftShootingPoint.global_rotation
		Game.call_deferred("add_child",new_flame3)
		lastflameshootable = false
		thirdflame = true
		%heavytimer.wait_time += 2
		%heavytimer.start()
		if leftorright == "right" :
			%Flamethrowerattachment.play("leftout")
		if leftorright == "left" :
			%Flamethrowerattachment.play("rightout")
		return

func _on_heavytimer_timeout() :
	firstflame = false
	secondflame = false
	thirdflame = false
	shootable = true
	lastflameshootable = true
	%heavytimer.stop()
	if leftorright == "left" :
		%Flamethrowerattachment.play("rightreloaded")
	elif leftorright == "right" :
		%Flamethrowerattachment.play("leftreloaded")


func _on_flamethrowerattachment_animation_finished() :
	%particlechecker.start()
	if leftorright == "left" :
		particlesleftbegin = true
		# Play Animation
		%Flamethrowerattachment.play("right")
		
	elif leftorright == "right" :
		particlesrightbegin = true
		# Play Animation
		%Flamethrowerattachment.play("left")


func _on_particlechecker_timeout() :
	if lastflameshootable == true :
		if particlesrightbegin == true :
			const FLAMETHROWER_READY_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var reloaded_flamethrower_particles = FLAMETHROWER_READY_PARTICLES.instantiate()
			reloaded_flamethrower_particles.flamethrowerreloaded_particles()
			reloaded_flamethrower_particles.global_position = %LeftShootingPoint.global_position
			reloaded_flamethrower_particles.position += Vector2(0,1.5).rotated(rotation) 
			reloaded_flamethrower_particles.rotation_degrees = rotation_degrees
			particleplayer.call_deferred("add_child", reloaded_flamethrower_particles)
		elif particlesleftbegin == true :
			const FLAMETHROWER_READY_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var reloaded_flamethrower_particles = FLAMETHROWER_READY_PARTICLES.instantiate()
			reloaded_flamethrower_particles.flamethrowerreloaded_particles()
			reloaded_flamethrower_particles.global_position = %RightShootingPoint.global_position
			reloaded_flamethrower_particles.position += Vector2(0,1.5).rotated(rotation) 
			reloaded_flamethrower_particles.rotation_degrees = rotation_degrees
			particleplayer.call_deferred("add_child", reloaded_flamethrower_particles)
	elif lastflameshootable == false :
		particlesrightbegin = false
		particlesleftbegin = false
		%particlechecker.stop()
