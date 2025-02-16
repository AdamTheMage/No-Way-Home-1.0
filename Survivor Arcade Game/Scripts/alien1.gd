extends CharacterBody2D

var enemyhealth = 3
var speed = 20
var enemyhealthchanged = false
var randomlymoving = false
var secondphase = false
var direction = Vector2.ZERO

static var heavy_pickups = 0

@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

func _ready() :
	gamelevel.alien1_count += 1

# Movement
func _physics_process(_delta):
	if randomlymoving == false :
		direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
# Change of properties on level increase :
	if gamelevel.level < 3 :
		enemyhealth = 1
	if gamelevel.level >= 3 and enemyhealthchanged == false :
		enemyhealthchanged = true
		enemyhealth = 3
# Checks Appearance
	if enemyhealth == 3 :
		if gamelevel.level >= 3 :
			%alien1.play("DefaultBlue")
		else :
			%alien1.play("Default")
	if enemyhealth <= 2 :
		secondphase = true
		if gamelevel.level >= 3 :
			%alien1.play("AttackingBlue")
		else :
			%alien1.play("Attacking")

func _on_alien_box_body_entered(body) :
	if body.has_method("asteroidsknockeachother") :
		if body.speed > 15 :
			take_asteroid_collision_damage()

func alien1_knockback () :
	# used as an indicator
	pass
	
# Mob Taking Damage and Death

# Special Effects
	# Weather
func meteored () :
	hurtparticles()
	enemyhealth -= 2
	speed = 18.75
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_asteroid_collision_damage() :
	hurtparticles()
	enemyhealth -= 1
	speed = 18.75
	
	if enemyhealth <= 0 : 
		aliendeath()

	# Abilities
func zapped() :
	hurtparticles()
	enemyhealth -= 2
	speed = 18.75
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_primarydamage() :
	hurtparticles()
	enemyhealth -= 1
	speed = 18.75
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_heavydamage() :
	hurtparticles()
	enemyhealth -= 4
	speed = 18.75
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func flamethrowered() :
	hurtparticles()
	enemyhealth -= 2
	speed = 18.75
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func hornsliced() :
	hurtparticles()
	enemyhealth -= 2
	speed = 18.75
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

# Particles

func hurtparticles() :
	if get_node("/root/Game").pocketedition == false :
		const BLOOD_EFFECT = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var blood = BLOOD_EFFECT.instantiate()
		if gamelevel.level >= 3 :
			blood.alien1bloodblue()
		else :
			blood.alien1blood()
		particleplayer.call_deferred("add_child", blood)
		blood.global_position = global_position 

func aliendeath():
		gamelevel.alien1_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien1kill()
			
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
			
		# Soul Pickup
		var new_soul1 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		if gamelevel.level >= 3 :
			new_soul1.soultype = 5
		else :
			new_soul1.soultype = 1
		new_soul1.global_position = %alien1.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul1)
			
			#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 24)))
		if loot_chance == 10 :
			var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
			new_heavyweaponpickup.global_position = %alien1.global_position
			new_heavyweaponpickup.lootflip()
			get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func lenurcherimplosion() :
		gamelevel.alien1_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien1kill()
			
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		# Soul Pickup
		var new_soul1 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		if gamelevel.level >= 3 :
			new_soul1.soultype = 5
		else :
			new_soul1.soultype = 1
		new_soul1.global_position = %alien1.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul1)
			
			#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 24)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup() 
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %alien1.global_position
				new_heavyweaponpickup.lootflip()
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func aliendeathnosoul () :
	gamelevel.alien1_count -= 1
	queue_free()

func _on_randommovement_timeout() :
	if secondphase == false :
		randomlymoving = true
		randomize()
		var rand1 = randf_range(-1.8, 1.8)
		var rand2 = randf_range(-1.5, 1.5)
		direction = global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
	else : 
		randomlymoving = false
		speed = 18.75
