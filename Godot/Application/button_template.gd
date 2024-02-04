extends Button

@export_file("*.tscn") var urlToHistoryItem: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file(urlToHistoryItem)

func setup(data):
	$Panel/TextureRect/Title.text = data['title']

	var image = Image.new()
	var raw_image = Marshalls.base64_to_raw(data['image']['$binary']['base64'])

	image.load_jpg_from_buffer(raw_image)
	
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	$Panel/TextureRect.texture = image_texture
