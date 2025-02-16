extends Area2D

var leftorright 

var point1reloaded = true
var point2reloaded = true
var point3reloaded = true
var point2abouttobereloaded = false
var projectile1ready = false
var projectile2ready = false
var projectile3ready = false

@onready var Game = get_node("/root/Game")
@onready var player = get_node("/root/Game/PlayerCharacter/Spaceship")

func _process(_delta) :
	# Checks what's reloaded and ready :
	var new_projectile1
	var new_projectile2
	var new_projectile3
		
	if point1reloaded == true and projectile1ready == false :
		projectile1ready = true
		const PROJECTILE1 = preload("res://Survivor Arcade Game/Scenes/heavy_missile.tscn")
		new_projectile1 = PROJECTILE1.instantiate()
		new_projectile1.global_position = %ShootingPointOne.global_position
		new_projectile1.global_rotation = %ShootingPointOne.global_rotation
		new_projectile1.speed = 0
		new_projectile1.scale.x = 0.85
		new_projectile1.scale.y = 0.85
		%ShootingPointOne.add_child(new_projectile1)
	if point2reloaded == true and projectile2ready == false :
		projectile2ready = true
		const PROJECTILE2 = preload("res://Survivor Arcade Game/Scenes/heavy_missile.tscn")
		new_projectile2 = PROJECTILE2.instantiate()
		new_projectile2.global_position = %ShootingPointTwo.global_position
		new_projectile2.global_rotation = %ShootingPointTwo.global_rotation
		new_projectile2.speed = 0
		new_projectile2.scale.x = 0.85
		new_projectile2.scale.y = 0.85
		%ShootingPointTwo.add_child(new_projectile2)
	if point3reloaded == true and projectile3ready == false :
		projectile3ready = true
		const PROJECTILE3 = preload("res://Survivor Arcade Game/Scenes/heavy_missile.tscn")
		new_projectile3 = PROJECTILE3.instantiate()
		new_projectile3.global_position = %ShootingPointThree.global_position
		new_projectile3.global_rotation = %ShootingPointThree.global_rotation
		new_projectile3.speed = 0
		new_projectile3.scale.x = 0.85
		new_projectile3.scale.y = 0.85
		%ShootingPointThree.add_child(new_projectile3)
		
	# Checks inputs
	if Input.is_action_just_pressed("fire_left") :
		if leftorright == "left" :
			heavyshoot()
		await get_tree().create_timer(0.1).timeout
	elif Input.is_action_just_pressed("fire_right") :
		if leftorright == "right" :
			heavyshoot()
		await get_tree().create_timer(0.1).timeout
	
	# Unequip :
	if Game.nomoreleftmissile == true and leftorright == "left" :
		queue_free()
	elif Game.nomorerightmissile == true and leftorright == "right" :
		queue_free()

func heavyshoot():
	if point1reloaded == true :
		shootpoint1()
		return
	elif point2reloaded == true :
		shootpoint2()
		return
	elif point3reloaded == true :
		shootpoint3()
		return

func shootpoint1() :
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/heavy_missile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPointOne.global_position
	new_projectile.global_rotation = %ShootingPointOne.global_rotation
	%ShootingPointOne.add_child(new_projectile)
	point1reloaded = false
	projectile1ready = false
	%heavytimer.start()

func shootpoint2() :
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/heavy_missile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPointTwo.global_position
	new_projectile.global_rotation = %ShootingPointTwo.global_rotation
	%ShootingPointTwo.add_child(new_projectile)
	point2reloaded = false
	point2abouttobereloaded = false
	projectile2ready = false
	%heavytimer.start()

func shootpoint3() :
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/heavy_missile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPointThree.global_position
	new_projectile.global_rotation = %ShootingPointThree.global_rotation
	%ShootingPointThree.add_child(new_projectile)
	point3reloaded = false
	projectile3ready = false
	%heavytimer.start()

func _on_heavytimer_timeout() :
	if point1reloaded == false :
		point1reloaded = true
		return
	elif point3reloaded == false :
		point3reloaded = true
		return
	elif point2reloaded == false and point2abouttobereloaded == false :
		point2abouttobereloaded = true
		return
	else : 
		%heavytimer.stop()
		if leftorright == "left" :
			%middle.play("middlereloaded")
			%left.play("leftreloaded")
			%right.play("rightreloaded")
		elif leftorright == "right" :
			%middle.play("middlereloaded")
			%left.play("leftreloaded")
			%right.play("rightreloaded")
		await get_tree().create_timer(0.95).timeout
		if point2abouttobereloaded == true :
			point2reloaded = true
		return

func _on_middle_animation_finished() :
	if leftorright == "left" :
			%middle.play("middle")
			%left.play("left")
			%right.play("right")
	elif leftorright == "right" :
			%middle.play("middle")
			%left.play("left")
			%right.play("right")
