extends CharacterBody2D

var enemyhealth = 2

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")

# Movement
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 27.5
	move_and_slide()

# Animation change when attack
func on_ready():
	%alien3.play("Default")
	%Electrattack.visible = false
	
	
# Mob Taking Damage and Death

# Special Effects
func zapped() :
	print("hurt")
	enemyhealth -= 2
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien3kill()
		
		# Electrattack
		const ELECTRATTACK = preload("res://Survivor Arcade Game/Scenes/electrattack.tscn")
		var new_electrattack = ELECTRATTACK.instantiate()
		get_node("/root/Game/Effects").call_deferred("add_child",new_electrattack)
		new_electrattack.global_position = global_position
		await get_tree().create_timer(3).timeout
		new_electrattack.queue_free()

func take_primarydamage() :
	enemyhealth -= 1
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien3kill()
		
		# Electrattack
		const ELECTRATTACK = preload("res://Survivor Arcade Game/Scenes/electrattack.tscn")
		var new_electrattack = ELECTRATTACK.instantiate()
		get_node("/root/Game/Effects").call_deferred("add_child",new_electrattack)
		new_electrattack.global_position = global_position
		await get_tree().create_timer(3).timeout
		new_electrattack.queue_free()

func take_heavydamage() :
	enemyhealth -= 3
	%alien3.play("Attacking")
	
	if enemyhealth <= 0 : 
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien3kill() 
		
		#Electrattack
		Electrattack()
			
func Electrattack() :
	const ELECTRATTACK = preload("res://Survivor Arcade Game/Scenes/electrattack.tscn")
	var new_electrattack = ELECTRATTACK.instantiate()
	get_node("/root/Game/Effects").call_deferred("add_child",new_electrattack)
	new_electrattack.global_position = global_position
	await get_tree().create_timer(3).timeout
	new_electrattack.queue_free()
