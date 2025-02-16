extends Area2D

var direction = Vector2.ZERO
var onscreen = false
# Type is type of soul e.g. 1 (green) , 2 (purple) , 3 (blue) , 4 (grey) , 5 (bluey purple) ,
var soultype = 1              

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var gamelevel = get_node("/root/Game")

func _ready() :
	if soultype == 1 :
		%soulsprite.play("green")
	if soultype == 2 :
		%soulsprite.play("purple")
	if soultype == 3 :
		%soulsprite.play("grey")
	if soultype == 4 :
		%soulsprite.play("blueypurple")
	if soultype == 5 :
		%soulsprite.play("blue")
	if soultype == 6 :
		%soulsprite.play("blueyellow")
	if soultype == 7 :
		%soulsprite.play("draugal")
	if soultype == 8 :
		%soulsprite.play("lenurcher")

func _physics_process(delta) :
	position += direction * 65 * delta
	
	if gamelevel.level >= 3 :
		if soultype == 1 :
			soultype = 5
			%soulsprite.play("blue")
		if soultype == 2 :
			soultype = 4
			%soulsprite.play("blueypurple")


func _on_magnetarea_body_entered(body) :
	if body.has_method("soulmagnet") :
		%directionupdater.start()


func _on_body_entered(body) :
	if soultype == 1 or soultype == 4 or soultype == 6 :
		if body.has_method("soulreceive1") :
			body.soulreceive1()
			queue_free()
	if soultype == 2 or soultype == 5 or soultype == 3 :
		if body.has_method("soulreceive2") :
			body.soulreceive2()
			queue_free()
	if soultype == 7 :
		if body.has_method("soulreceive5") :
			body.soulreceive5()
			queue_free()
	if soultype == 8 :
		if body.has_method("soulreceivelenurcher") :
			body.soulreceivelenurcher()
			$/root/Game/PlayerCharacter/UI/stats.lenurcherdead()
			queue_free()

func _on_magnetarea_body_exited(body) :
	if body.has_method("soulmagnet") :
		direction = Vector2.ZERO


func _on_directionupdater_timeout() :
	direction = Vector2(1, 0).rotated(rotation)
	look_at(player.global_position)
	direction = global_position.direction_to(player.global_position)


func _on_despawn_timer_timeout() :
	if onscreen == false :
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() :
	onscreen = true


func _on_visible_on_screen_notifier_2d_screen_exited() :
	onscreen = false
