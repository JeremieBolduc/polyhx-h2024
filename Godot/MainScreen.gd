extends Control

@export_file("*.tscn") var urlToStartRecyling: String
@export_file("*.tscn") var urlToAboutUs: String
@export_file("*.tscn") var urlToOptions: String
@export_file("*.tscn") var urlToHistory: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_recycling_pressed():
	get_tree().change_scene_to_file(urlToStartRecyling)


func _on_about_us_pressed():
	get_tree().change_scene_to_file(urlToAboutUs)


func _on_options_pressed():
	get_tree().change_scene_to_file(urlToOptions)


func _on_help_pressed():
	get_tree().change_scene_to_file(urlToHistory)
