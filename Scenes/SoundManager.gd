extends Node2D


func maintheme():
	$Level1.playing = false
	$Level3.playing = false
	if $Maintheme.playing == false:
		$Maintheme.play()
func maintheme_stop():
	$Maintheme.stop()


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


func level1():
	$Level1.play()


func level3():
	$Level3.play()



