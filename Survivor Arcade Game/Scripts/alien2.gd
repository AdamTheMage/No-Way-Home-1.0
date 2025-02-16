extends CharacterBody2D

var enemyhealth = 7
var secondphase = false
var randomlymoving = false

static var heavy_pickups = 0

@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

func _ready() :
	gamelevel.alien2_count += 1

# Movement
func _physics_process(_delta):
	# Appearance Change
	if randomlymoving == false :
		if enemyhealth <= 4 : 
			secondphase = true
			%alien2.play("Attacking")
		if gamelevel.level >= 3 :
			%alien2.play("AttackingBlue")
	# Movement
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 2
	move_and_slide()
	
	if randomlymoving == false and enemyhealth >= 4 :
		%alien2.play("Default")
		if gamelevel.level >= 3 :
			%alien2.play("DefaultBlue")
		

func _on_alien_box_2_body_entered(body) :
	if body.has_method("asteroidsknockeachother") :
		if body.speed > 15 :
			take_asteroid_collision_damage()

# Animation change when attack
	
# Mob Taking Damage and Death

# Special Effects
	# Weather
func meteored () :
	hurtparticles()
	enemyhealth -= 2
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()
	
func take_asteroid_collision_damage() :
	hurtparticles() 
	enemyhealth -= 1
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

	# Abilities
func zapped() :
	hurtparticles()
	enemyhealth -= 2
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func take_primarydamage() :
	hurtparticles()
	enemyhealth -= 1
		
	if enemyhealth <= 0 :
		aliendeath()

func take_heavydamage() :
	hurtparticles()
	enemyhealth -= 4
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func flamethrowered() :
	hurtparticles()
	enemyhealth -= 2
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()
		
func hornsliced() :
	hurtparticles()
	enemyhealth -= 2
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

# Particles

func hurtparticles() :
	if get_node("/root/Game").pocketedition == false :
		const BLOOD_EFFECT = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var blood = BLOOD_EFFECT.instantiate()
		blood.alien2blood()
		particleplayer.call_deferred("add_child", blood)
		blood.global_position = global_position 

func aliendeath() :
		gamelevel.alien2_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien2kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/bigexplosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		# Soul Pickup
		var new_soul2 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul2.scale.x = 0.35
		new_soul2.scale.y = 0.35
		new_soul2.soultype = 3
		new_soul2.global_position = %alien2.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul2)
			
		#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 2)))
		if loot_chance == 1 :
			#alienloot.heavy_pickup()
			var new_warhornpickup = preload("res://Survivor Arcade Game/Scenes/warhorn_pickup.tscn").instantiate()
			new_warhornpickup.global_position = %alien2.global_position
			get_node("/root/Game/Pickups").call_deferred("add_child",new_warhornpickup)

func lenurcherimplosion() :
		gamelevel.alien2_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien2kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/bigexplosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		# Soul Pickup
		var new_soul2 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul2.scale.x = 0.35
		new_soul2.scale.y = 0.35
		new_soul2.soultype = 3
		new_soul2.global_position = %alien2.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul2)
		
		#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 2)))
		if loot_chance == 1 :
			#alienloot.heavy_pickup()
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_warhornpickup = preload("res://Survivor Arcade Game/Scenes/warhorn_pickup.tscn").instantiate()
				new_warhornpickup.global_position = %alien2.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_warhornpickup)

func aliendeathnosoul () :
	gamelevel.alien2_count -= 1
	queue_free()

func _on_randommovement_timeout() :
	if secondphase == false :
		randomlymoving = true
		%alien2.play("Teleporting")
		await get_tree().create_timer(1.4).timeout
		randomize()
		if player.global_position.x - global_position.x >= 0 and player.global_position.y - global_position.y >= 0 :
			var rand1 = randf_range(0, 35.75)
			var rand2 = randf_range(35.8, 0)
			position += global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
		if player.global_position.x - global_position.x <= 0 and player.global_position.y - global_position.y >= 0 :
			var rand1 = randf_range(-35.8, 0)
			var rand2 = randf_range(35.75, 0)
			position += global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
		if player.global_position.x - global_position.x >= 0 and player.global_position.y - global_position.y <= 0 :
			var rand1 = randf_range(0, 35.8)
			var rand2 = randf_range(-35.75, 0)
			position += global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
		if player.global_position.x - global_position.x <= 0 and player.global_position.y - global_position.y <= 0 :
			var rand1 = randf_range(-35.75, 0)
			var rand2 = randf_range(-35.8, 0)
			position += global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
		await get_tree().create_timer(1.075).timeout
		randomlymoving = false
	else : 
		randomlymoving = false
