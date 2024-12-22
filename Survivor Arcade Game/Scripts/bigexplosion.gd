extends AnimatedSprite2D

func on_ready():
	get_node("BigExplosion").play("death")
