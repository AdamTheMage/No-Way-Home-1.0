extends CharacterBody2D

var enemyhealth = 5

static var heavy_pickups = 0

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

# Movement
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 8.5
	move_and_slide()

# Animation change when attack
func on_ready():
	%alien2.play("Default")
	
# Checks what appearance should be active on timeout
func _on_appearancechecker_timeout() :
	if enemyhealth >= 4 :
		if gamelevel.level2 == true :
			%alien2.play("DefaultBlue")
# Mob Taking Damage and Death

# Special Effects
func zapped() :
	enemyhealth -= 2
	%alien2.play("Attacking")
	if gamelevel.level2 == true :
		%alien2.play("AttackingBlue")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien2kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/big_zap_explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 10)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup()
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %alien2.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func take_primarydamage() :
	enemyhealth -= 1
	if enemyhealth <= 2 : 
		%alien2.play("Attacking")
		if gamelevel.level2 == true :
			%alien2.play("AttackingBlue")
		
		if enemyhealth <= 0 :
			queue_free()
			$/root/Game/PlayerCharacter/UI/stats.add_alien2kill()
				
			#Smoke Effect
			const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/bigexplosion.tscn")
			var smoke = SMOKE_EFFECT.instantiate()
			get_parent().add_child(smoke)
			smoke.global_position = global_position
				
				#Heavy Weapon Loot
			randomize()
			var loot_chance = int(round(randi_range(1, 10)))
			if loot_chance == 10 :
				#alienloot.heavy_pickup() 
				if heavy_pickups < 2 :
					heavy_pickups += 1
					var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_pickup.tscn").instantiate()
					new_heavyweaponpickup.global_position = %alien2.global_position
					get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func take_heavydamage() :
	enemyhealth -= 3
	%alien2.play("Attacking")
	if gamelevel.level2 == true :
		%alien2.play("AttackingBlue")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien2kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/bigexplosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 10)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup()
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %alien2.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
				
