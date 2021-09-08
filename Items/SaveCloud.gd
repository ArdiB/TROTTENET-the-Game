extends StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/TransitionScreen".connect("transitioned2", self, ("_transitioned2"))

func _transitioned2():
	print("hallo")
	$AnimatedSprite.playing = true

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
