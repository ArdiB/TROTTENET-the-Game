extends Node2D



func _ready():
	$"Timer/Tween Size".interpolate_property(self, "position", Vector2(0, 0),Vector2(160, 90), 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#$"Timer/Tween Position".start()
	$"Timer/Tween Size".interpolate_property($Timer.get_font("font"), "size", 10, 30, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$"Timer/Tween Size".start()
	
