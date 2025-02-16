extends Area2D

var direction = Vector2.ZERO
var stopfollowing = false
var onscreen = false
var pickuprange = false
var outofrange = false

@onready var stardust_count = get_node("/root/Game/PlayerCharacter/UI/stats")
@onready var stardust = get_node("/root/Game")
@onready var player = get_node("/root/Game/PlayerCharacter")
# When the player enters the collision, stardust dissapears and is added to the tally

func _physics_process(delta) :
	position += direction * 30 * delta
	if stopfollowing == true :
		direction = Vector2.ZERO

func _on_body_entered(_PlayerCharacter) :
	pickuprange = true
	stardust_count.add_stardust()
	queue_free()

func _on_body_exited(_PlayerCharacter) :
	pickuprange = false

func _on_magnetarea_body_entered(_PlayerCharacter) :
	%directionupdater.start()
	outofrange = false

func _on_directionupdater_timeout() :
	if outofrange == false :
		direction = Vector2(1, 0).rotated(rotation)
		look_at(player.global_position)
		direction = global_position.direction_to(player.global_position)

func _on_magnetarea_body_exited(_PlayerCharacter) :
	direction = Vector2.ZERO
	outofrange = true

# Despawn :
func _on_despawn_timer_timeout() :
	if onscreen == false :
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() : 
	onscreen = true


func _on_visible_on_screen_notifier_2d_screen_exited() : 
	onscreen = false
