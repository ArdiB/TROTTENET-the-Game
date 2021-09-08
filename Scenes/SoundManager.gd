extends Node2D


func crash():
	if $Crash.playing == false:
		$Crash.play()
	
func speed_up():
		$SpeedUp.play()
	
func jump():
		$Jump.play()
	
func countdown():
		$Countdown.play()
	
func music1():
		$Music1.play()
