extends Area2D

var travelled_distance = 0
var direction = Vector2(1, 0).rotated(rotation)

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var particleplayer = get_node("/root/Game/particleplayer")

func _physics_process(delta):
	const RANGE = 325
	direction = Vector2(1, 0).rotated(rotation)
	
	position += direction * 20 * delta
	
	travelled_distance += 100 * delta
	
	if travelled_distance > RANGE :
		queue_free()

func _ready() :
	# Particles
	if get_node("/root/Game").pocketedition == false :
		const SPEW_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var spewparticles = SPEW_PARTICLES.instantiate()
		spewparticles.gugglerspewparticles()
		spewparticles.global_position = Vector2(1,0).rotated(rotation) + global_position
		spewparticles.position += Vector2(14,0).rotated(rotation)
		spewparticles.rotation_degrees = rotation_degrees + 180
		spewparticles.spewdirection = direction
		particleplayer.call_deferred("add_child", spewparticles)
		
		await get_tree().create_timer(0.25).timeout
		const SPEW_PARTICLES2 = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var spewparticles2 = SPEW_PARTICLES2.instantiate()
		spewparticles2.gugglerspewparticles()
		spewparticles2.global_position = Vector2(1,0).rotated(rotation) + global_position
		spewparticles2.position += Vector2(21,0).rotated(rotation) 
		spewparticles2.rotation_degrees = rotation_degrees + 180
		spewparticles2.spewdirection = direction
		particleplayer.call_deferred("add_child", spewparticles2)
		
		await get_tree().create_timer(0.25).timeout
		%secondcollision.disabled = false
		await get_tree().create_timer(0.4).timeout
		const SPEW_PARTICLES4 = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var spewparticles4 = SPEW_PARTICLES4.instantiate()
		spewparticles4.gugglerspewparticles()
		spewparticles4.global_position = Vector2(1,0).rotated(rotation) + global_position
		spewparticles4.position += Vector2(32,0).rotated(rotation) 
		spewparticles4.rotation_degrees = rotation_degrees + 180
		spewparticles4.spewdirection = direction
		particleplayer.call_deferred("add_child", spewparticles4)

		await get_tree().create_timer(0.4).timeout
		const SPEW_PARTICLES5 = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var spewparticles5 = SPEW_PARTICLES5.instantiate()
		spewparticles5.gugglerspewparticles()
		spewparticles5.global_position = Vector2(1,0).rotated(rotation) + global_position
		spewparticles5.position += Vector2(32,0).rotated(rotation) 
		spewparticles5.rotation_degrees = rotation_degrees + 180
		spewparticles5.spewdirection = direction
		particleplayer.call_deferred("add_child", spewparticles5)
			
		await get_tree().create_timer(0.4).timeout
		const SPEW_PARTICLES3 = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var spewparticles3 = SPEW_PARTICLES3.instantiate()
		spewparticles3.gugglerspewparticles()
		spewparticles3.global_position = Vector2(1,0).rotated(rotation) + global_position
		spewparticles3.position += Vector2(33,0).rotated(rotation) 
		spewparticles3.rotation_degrees = rotation_degrees + 180
		spewparticles3.spewdirection = direction
		particleplayer.call_deferred("add_child", spewparticles3)
		await get_tree().create_timer(0.55).timeout
		%Spew.play("leaving")
	else :
		await get_tree().create_timer(0.5).timeout
		%secondcollision.disabled = false
		await get_tree().create_timer(1.75).timeout
		%Spew.play("leaving")

func _on_body_entered(body):
	if body.has_method("take_gugglerspewdamage"):
		body.take_gugglerspewdamage()

	
