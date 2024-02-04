extends Control

@export_file("*.tscn") var urlToMainMenu: String
@export_file("*.tscn") var mainMenu: String
@export_file("*.tscn") var about: String
@export_file("*.tscn") var howTo: String
@export_file("*.tscn") var history: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_go_back_pressed():
	get_tree().change_scene_to_file(urlToMainMenu)


func _on_texture_button_pressed():
	get_tree().change_scene_to_file(mainMenu)



func _on_aboutus_pressed():
	get_tree().change_scene_to_file(about)


func _on_home_pressed():
	get_tree().change_scene_to_file(mainMenu)


func _on_howto_pressed():
	get_tree().change_scene_to_file(howTo)


func _on_history_pressed():
	get_tree().change_scene_to_file(history)
