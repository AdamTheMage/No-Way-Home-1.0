extends Area2D

var travelled_distance = 0
var direction = Vector2(1, 0).rotated(rotation)
var smallest = false
var medium = false

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var particleplayer = get_node("/root/Game/particleplayer")

# Particles vars and constants :
const FLAMETHROWER_FLAME_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
var flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()

func _physics_process(delta):
	const RANGE = 325
	direction = Vector2(1, 0).rotated(rotation)
	
	position += direction * 30 * delta
	
	travelled_distance += 100 * delta
	
	if travelled_distance > RANGE :
		queue_free()

func _ready() :
	if get_node("/root/Game").pocketedition == false :
		randomize()
		var randommovement = randf_range(-0.4, 0.4)
		%Flame.play("fired")
		await get_tree().create_timer(0.1).timeout
		# Particles
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		flameparticles.position += Vector2(11,0).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 180
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		%secondcollision1.visible = false
		%secondcollision2.visible = false
		await get_tree().create_timer(0.05).timeout
		# Particle
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		flameparticles.position += Vector2(16,3.25).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 180
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		%thirdcollision.disabled = false
		await get_tree().create_timer(0.1).timeout
		# Particle
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		flameparticles.position += Vector2(13,-2.75).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 180
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		%fourthcollision1.disabled = false
		%fourthcollision2.disabled = false
		await get_tree().create_timer(0.25).timeout
		# More Particles - set 1 :
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(20, 2).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(13.5,1.35).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(10,1).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 10
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(22, -6.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(14.85,-4.39).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(11,-3.25).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 23
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(25, 4.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(17,3.04).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(12.5,2.25).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 56
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		await get_tree().create_timer(0.2).timeout

		# Set 2 :
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(24,-1.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(16.2,-0.95).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(12,-0.75).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 40
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(26,3.75).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(14.25,2.53).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(13,1.875).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 23
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(27.5,-7.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(15.75,-5.06).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(13.75,-3.75).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 84
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		await get_tree().create_timer(0.2).timeout
		# Set 3 :
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(28,1.75).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(18.25,1.1).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(14,0.875).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 10
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)

		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(30.5,4.25).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(19.75,2.87).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(15.25,2.125).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 15
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(33.75,-0.9).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(21.75,-0.55).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(16.85,-0.45).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 28
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		await get_tree().create_timer(0.2).timeout
		# Set 4 :
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(32,-2.4).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(21.5,-1.62).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(16,-1.2).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 35 
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(30.5,-7.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(20,-5.06).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(15.25,-3.75).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 55
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(29.75,6.75).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(19,4.56).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(14.85,3.325).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 55
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(31.5,-4.38).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(22,-3.25).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(15.65,-2.19).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 20 
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(30.75,5.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(20,3.71).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(15.25,2.75).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 60
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		await get_tree().create_timer(0.25).timeout
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(31.75,4.25).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(21,2.8).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(15.25,2.1).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 10 
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		await get_tree().create_timer(0.15).timeout
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(33.25,-2.5).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(22.25,-1.6).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(16.25,-1.2).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 25
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		await get_tree().create_timer(0.15).timeout
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(33.25,0.25).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(22.25,0.15).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(16.25, 0.5).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees - 5
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
		print ("leaving")
		%Flame.play("leaving")
		await get_tree().create_timer(0.15).timeout
		
		flameparticles = FLAMETHROWER_FLAME_PARTICLES.instantiate()
		flameparticles.flamethrower_particles()
		flameparticles.global_position = Vector2(1, randommovement).rotated(rotation) + global_position
		if smallest == false and medium == false :
			flameparticles.position += Vector2(33.25,-0.6).rotated(rotation)
		if medium == true :
			flameparticles.position += Vector2(22.25,-0.4).rotated(rotation)
		if smallest == true :
			flameparticles.position += Vector2(16.25,-0.2).rotated(rotation)
		flameparticles.rotation_degrees = rotation_degrees + 15
		flameparticles.flamedirection = direction
		particleplayer.call_deferred("add_child", flameparticles)
	else :
		%Flame.play("fired")
		await get_tree().create_timer(0.1).timeout
		%secondcollision1.visible = false
		%secondcollision2.visible = false
		await get_tree().create_timer(0.05).timeout
		%thirdcollision.disabled = false
		await get_tree().create_timer(0.1).timeout
		%fourthcollision1.disabled = false
		%fourthcollision2.disabled = false
		await get_tree().create_timer(1.4).timeout
		%Flame.play("leaving")

func _on_body_entered(body) :
	if body.has_method("flamethrowered") :
		body.flamethrowered()
