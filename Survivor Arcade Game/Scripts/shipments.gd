extends CharacterBody2D

var dronepickupchance = 0
var starfuelpickupchance = 0
var flamethrowerpickupchance = 0
var lockonmissilepickupchance = 0
var shipmenttype = 0
var onscreen = false
var shipmentdamagedchance = 0
var shipmenthealth = 1 # just so its clear we don't need a health system
var direction = Vector2.ZERO
var speed = 0
var originalspeed = 0
var randrotation = 0
var randscale = 0


@onready var Game = get_node("/root/Game")
@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")

func _physics_process(_delta) :
	$".".rotation_degrees += randrotation
	velocity = direction * speed 
	move_and_slide()

func _ready() :
	Game.shipmentcount += 1
	%shipment1.disabled = true
	%shipment2.disabled = true
	%shipment3.disabled = true
	randomize()
	shipmenttype = randi_range(1, 3)
	shipmentdamagedchance = randi_range(1, 2)
	if shipmenttype == 1 :
		if shipmentdamagedchance == 1 :
			%shipmenttype.play("shipment1")
		elif shipmentdamagedchance == 2 :
			%shipmenttype.play("shipment1broke")
		%shipment1.disabled = false
	if shipmenttype == 2 :
		if shipmentdamagedchance == 1 :
			%shipmenttype.play("shipment2")
		elif shipmentdamagedchance == 2 :
			%shipmenttype.play("shipment2broke")
		%shipment2.disabled = false
	if shipmenttype == 3 :
		if shipmentdamagedchance == 3 :
			%shipmenttype.play("shipment3")
		elif shipmentdamagedchance == 2 :
			%shipmenttype.play("shipment3broke")
		%shipment3.disabled = false
	# Movement
	randrotation = randf_range(-0.2, 0.2)
	randscale = randf_range(0.8, 1.2)
	$".".scale.x = randscale
	$".".scale.y = randscale
	$".".rotation_degrees = randf_range(0, 360)
	var randx = randf_range(-1, 1)
	var randy = randf_range(-1, 1)
	direction = Vector2(randx, randy)
	speed = randf_range(0.25, 5)
	originalspeed = speed

func _on_area_2d_body_entered(body) :
	if body.has_method("knocksaround") :
		const SHIPMENT_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var shipmentparticles = SHIPMENT_PARTICLES.instantiate()
		shipmentparticles.shipmentexplosion()
		particleplayer.call_deferred("add_child", shipmentparticles)
		shipmentparticles.global_position = global_position
		shipmentparticles.global_rotation = global_rotation
		speed = player.max_speed * randscale + speed / 2
		direction = player.direction
		%slowdown.start()

func _on_slowdown_timeout() :
	if speed > originalspeed :
		speed -= 2

# Ways to be damaged :
func meteored () :
	shipmentdestroyed()

func zapped () :
	shipmentdestroyed()

func flamethrowered() :
	shipmentdestroyed()

func take_primarydamage () :
	shipmentdestroyed()

func take_heavydamage () :
	shipmentdestroyed() 

func shipmentdestroyed () :
	const SHIPMENT_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
	var shipmentparticles = SHIPMENT_PARTICLES.instantiate()
	shipmentparticles.shipmentexplosion()
	particleplayer.call_deferred("add_child", shipmentparticles)
	shipmentparticles.global_position = global_position
	shipmentparticles.global_rotation = global_rotation
	Game.shipmentcount -= 1
	if shipmenttype == 1 :
		%shipmenttype.play("shipment1breaking")
	elif shipmenttype == 2 :
		%shipmenttype.play("shipment2breaking")
	elif shipmenttype == 3 :
		%shipmenttype.play("shipment3breaking")
	await get_tree().create_timer(0.2).timeout
	randomize()
	dronepickupchance = randi_range(1, 40)
	starfuelpickupchance = randi_range(1, 3)
	flamethrowerpickupchance = randi_range(1, 12)
	lockonmissilepickupchance = randi_range(1, 12)
	# if you get lucky you get drone else 1/2 chance of starfuel
	if dronepickupchance == 12 :
		var new_dronepickup = preload("res://Survivor Arcade Game/Scenes/dronepickup.tscn").instantiate()
		new_dronepickup.global_position = global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_dronepickup)
		
	if flamethrowerpickupchance == 1 :
		if get_node("/root/Game").flamethrowerpickups < 2 :
			get_node("/root/Game").flamethrowerpickups += 1
			var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
			new_flamethrowerpickup.global_position = global_position
			new_flamethrowerpickup.lootflip()
			get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)
	if lockonmissilepickupchance == 1 :
		var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
		new_heavyweaponpickup.global_position = global_position
		new_heavyweaponpickup.lootflip()
		get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
	
	if starfuelpickupchance == 1 or 2 :
		var new_starfuel= preload("res://Survivor Arcade Game/Scenes/fuel_system.tscn").instantiate()
		new_starfuel.global_position  = global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_starfuel)
		queue_free()
	else :
		queue_free()
		


func _on_despawntimer_timeout() :
	if onscreen == false :
		Game.shipmentcount -= 1
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() :
	onscreen = false


func _on_visible_on_screen_notifier_2d_screen_exited() :
	onscreen = true
