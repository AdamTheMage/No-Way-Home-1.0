extends AnimatedSprite2D

func on_ready():
	get_node("Explosion").play("death")
