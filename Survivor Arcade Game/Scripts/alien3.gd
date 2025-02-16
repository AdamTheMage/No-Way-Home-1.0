extends CharacterBody2D

var enemyhealth = 1
var randomlymoving = false
var direction = Vector2.ZERO

@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

func _ready() :
	gamelevel.alien3_count += 1

# Movement
func _physics_process(_delta):
	if randomlymoving == false :
		direction = global_position.direction_to(player.global_position)
	velocity = direction * 27.5
	move_and_slide()
	
func alien3_knockback () :
	# used as an indicator
	pass

# Animation change when attack
func on_ready():
	%alien3.play("Default")
	%Electrattack.visible = false
	
	
# Mob Taking Damage and Death

# Special Effects
	# Weather
func meteored () :
	hurtparticles()
	enemyhealth -= 2
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_asteroid_collision_damage() :
	hurtparticles()
	enemyhealth -= 1
	
	if enemyhealth <= 0 : 
		aliendeath()

	# Abilities
func zapped() :
	hurtparticles()
	enemyhealth -= 2
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_primarydamage() :
	hurtparticles()
	enemyhealth -= 1
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_heavydamage() :
	hurtparticles()
	enemyhealth -= 4
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		aliendeath()

func flamethrowered() :
	hurtparticles()
	enemyhealth -= 2
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		aliendeath()

func hornsliced() :
	hurtparticles()
	enemyhealth -= 2
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		aliendeath()

# Particles

func hurtparticles() :
	if get_node("/root/Game").pocketedition == false :
		const BLOOD_EFFECT = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var blood = BLOOD_EFFECT.instantiate()
		blood.alien3blood()
		particleplayer.call_deferred("add_child", blood)
		blood.global_position = global_position 
	
func Electrattack() :
	const ELECTRATTACK = preload("res://Survivor Arcade Game/Scenes/electrattack.tscn")
	var new_electrattack = ELECTRATTACK.instantiate()
	get_node("/root/Game/Effects").call_deferred("add_child",new_electrattack)
	new_electrattack.global_position = global_position
	await get_tree().create_timer(3).timeout
	new_electrattack.queue_free()

func aliendeath() :
		gamelevel.alien3_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien3kill() 
		
		# Soul Pickup
		var new_soul1 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul1.scale.x = -0.35
		new_soul1.scale.y = -0.35
		new_soul1.soultype = 6
		new_soul1.global_position = %alien3.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul1)
		
		#Electrattack
		Electrattack()

func lenurcherimplosion() :
	gamelevel.alien3_count -= 1
	queue_free()
	$/root/Game/PlayerCharacter/UI/stats.add_alien3kill() 
		
	# Soul Pickup
	var new_soul1 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
	new_soul1.scale.x = -0.35
	new_soul1.scale.y = -0.35
	new_soul1.soultype = 6
	new_soul1.global_position = %alien3.global_position
	get_node("/root/Game/Pickups").call_deferred("add_child",new_soul1)
		
	#Electrattack
	Electrattack()

func aliendeathnosoul () :
	gamelevel.alien3_count -= 1
	queue_free()
	
# Random Movement

func _on_randommovement_timeout() :
	randomlymoving = true
	randomize()
	if player.global_position.x - global_position.x >= 0 and player.global_position.y - global_position.y >= 0 :
		var rand1 = randf_range(0, 1.75)
		var rand2 = randf_range(0.8, 0)
		direction = global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
	if player.global_position.x - global_position.x <= 0 and player.global_position.y - global_position.y >= 0 :
		var rand1 = randf_range(-0.8, 0)
		var rand2 = randf_range(1.75, 0)
		direction = global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
	if player.global_position.x - global_position.x >= 0 and player.global_position.y - global_position.y <= 0 :
		var rand1 = randf_range(0, 0.8)
		var rand2 = randf_range(-1.75, 0)
		direction = global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
	if player.global_position.x - global_position.x <= 0 and player.global_position.y - global_position.y <= 0 :
		var rand1 = randf_range(-1.75, 0)
		var rand2 = randf_range(-0.8, 0)
		direction = global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
	await get_tree().create_timer(1).timeout
	randomlymoving = false

# Suicide Contact With Player :
func _on_alien_box_body_entered(body) :
	if body.has_method("play_zapped_label") :
		aliendeath()
		queue_free()
	if body.has_method("asteroidsknockeachother") :
		if body.speed > 15 :
			take_asteroid_collision_damage()


func _on_alien_box_area_entered(area) :
		if area.has_method("zappedcheck") :
			aliendeath()
			queue_free()
