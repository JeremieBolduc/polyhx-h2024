extends Control

@export_file("*.tscn") var urlToPlastic: String
@export_file("*.tscn") var urlToMetal: String
@export_file("*.tscn") var urlToPaper: String
@export_file("*.tscn") var urlToGlass: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_plastic_2_pressed():
	get_tree().change_scene_to_file(urlToPlastic)


func _on_metal_2_pressed():
	get_tree().change_scene_to_file(urlToMetal)


func _on_paper_3_pressed():
	get_tree().change_scene_to_file(urlToPaper)


func _on_glass_2_pressed():
	get_tree().change_scene_to_file(urlToGlass)
