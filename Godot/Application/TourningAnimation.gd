extends Control

var maxValue: int = 100
var currentValue: int = 0

func _ready():
	$TextureProgressBar.max_value = maxValue

func _process(delta):
	$TextureProgressBar.value = (currentValue % maxValue)

func _on_timer_timeout():
	currentValue += 6
