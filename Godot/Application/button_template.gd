extends Button

@export_file("*.tscn") var urlToHistoryItem: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file(urlToHistoryItem)

func setup(data):
	$Panel/TextureRect/Title.text = data['title']
	#$Panel/TextureRect/Date.text = data['creationDate']
	var image = Image.new()
	
	#var r = JSON.parse_string(data['image'])
	print(type_string(typeof(data['image'])))


	#image.load_jpg_from_buffer(data['image'])
	
	#var image_texture = ImageTexture.new()
	#image_texture.set_image(image)
	#
	#$Panel/sprite.texture = image_texture
