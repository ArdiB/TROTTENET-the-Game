extends Label

var time = 0

func _process(delta):
	
	time += delta
	
	var secs = fmod(time, 60)
	var mins = fmod(time, 60*60) /60
	
	var time_passed = "%02d : %02d" % [mins,secs]
	self.text = time_passed
