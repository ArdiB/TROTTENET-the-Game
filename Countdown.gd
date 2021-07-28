extends Label

signal start 
var time_counter = 3

func _ready():
	update_label()




func _on_Timer_timeout():
	time_counter -= 1
	update_label()
	if time_counter == 0:
		self.text = "START"
	if time_counter < 0:
		$Timer.one_shot = true
		self.visible = false
	
	
func update_label():
	self.text = str(time_counter)
