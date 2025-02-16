extends Area2D

var travelled_distance = 0

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var particleplayer = get_node("/root/Game/particleplayer")

func _ready() :
	%CollisionShape2D.disabled = true

func _physics_process(delta):
	const RANGE = 900
	var direction = Vector2(1, 0).rotated(rotation)
	
	look_at(player.global_position)
	direction = global_position.direction_to(player.global_position)
	
	position += direction * 45 * delta
	
	travelled_distance += 100 * delta
	
	if travelled_distance > RANGE :
		queue_free()
	


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_draugaldamage"):
		body.take_draugaldamage()

func neutralise_draugal_missile () :
	const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
	var smoke = SMOKE_EFFECT.instantiate()
	smoke.scale.x = -0.25
	smoke.scale.y = -0.25
	get_parent().add_child(smoke)
	smoke.global_position = global_position
	queue_free()


func _on_particlerelease_timeout() :
	if get_node("/root/Game").pocketedition == false :
		const MISSILETRAIL_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var missiletrailparticles = MISSILETRAIL_PARTICLES.instantiate()
		missiletrailparticles.alien4missileparticles()
		particleplayer.call_deferred("add_child", missiletrailparticles)
		missiletrailparticles.global_position = global_position
		missiletrailparticles.global_rotation = global_rotation


func _on_hittimer_timeout() :
	%CollisionShape2D.disabled = false
