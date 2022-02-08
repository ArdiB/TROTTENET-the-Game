extends Node2D


func maintheme():
	if $Maintheme.playing == false:
		$Maintheme.play()
func _on_Maintheme_finished():
	$Maintheme.play()
func crash():
	if $Crash.playing == false:
		$Crash.play()
	
func speed_up():
	$SpeedUp.play()
	
func jump():
	$Jump.play()
	
func countdown():
	$Countdown.play()
func speed_boost():
	$SpeedBoost.play()
	
func music1():
		$Music1.play()






