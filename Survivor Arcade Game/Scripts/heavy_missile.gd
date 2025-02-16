extends Area2D

var maintarget 
var speed = 50
var travelled_distance = 0
var targetacquired = false

var direction = Vector2(1, 0).rotated(rotation)

@onready var particleplayer = get_node("/root/Game/particleplayer")

func _physics_process(delta):
	# For the missiles ready to fire (not actually firing)
	if speed == 0 :
		global_position = get_parent().global_position
		global_rotation = get_parent().global_rotation
		$".".monitoring = false
		%missileradar.monitoring = false
	
	if speed > 0 :
		const RANGE = 600
		
		direction = Vector2(1, 0).rotated(rotation)
		position += direction * speed * delta
		
		travelled_distance += 100 * delta
		
		if travelled_distance > RANGE :
			queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_heavydamage"):
		body.take_heavydamage()


func _on_missileradar_body_entered(body) :
	if targetacquired == false :
		travelled_distance = 0
		maintarget = body
		%MissileFollower.start()
		look_at(body.global_position)
		direction = global_position.direction_to(body.global_position)
		targetacquired = true



func destroyself() :
	queue_free()

func _on_missile_follower_timeout() :
	if is_instance_valid(maintarget) :
		look_at(maintarget.global_position)
		direction = global_position.direction_to(maintarget.global_position)
		if get_node("/root/Game").pocketedition == false :
			const MISSILETRAIL_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var missiletrailparticles = MISSILETRAIL_PARTICLES.instantiate()
			missiletrailparticles.lockonmissiletrail()
			particleplayer.call_deferred("add_child", missiletrailparticles)
			missiletrailparticles.global_position = global_position
			missiletrailparticles.global_rotation = global_rotation


func _on_area_entered(area) :
	print("inter")
	if area.has_method("destroyself") :
		if area.speed == 0 :
			print("interdestroy")
			area.destroyself()
