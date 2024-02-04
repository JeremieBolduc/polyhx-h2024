extends Control

var image = null
var globalPath = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	disable_and_hide_node($VBoxContainer/Confirm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func disable_and_hide_node(node:Node) -> void:
	node.process_mode = 4 # = Mode: Disabled
	node.hide()

func enable_and_show_node(node:Node) -> void:
	node.process_mode = 0 # = Mode: Inherit
	node.show()

func _on_upload_an_image_pressed():
	$FileDialog.popup()

func _on_file_dialog_file_selected(path):
	enable_and_show_node($VBoxContainer/Confirm)
	globalPath = path
	image = Image.new()
	image.load(path)
	
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	
	$ColorRect/TextureRect.texture = image_texture


func _on_confirm_pressed():
	if image != null && globalPath != '':
		var imageData = image.get_data()
		var imageBase64 = Marshalls.raw_to_base64(imageData)
		
