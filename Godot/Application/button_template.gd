extends Button

@export_file("*.tscn") var urlToHistoryItem: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	print("okesdpofks")
	get_tree().change_scene_to_file(urlToHistoryItem)

func setup(itemInfo):
	pass