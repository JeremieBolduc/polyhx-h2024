extends Control

var file = null
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
	file = FileAccess.open(path, FileAccess.READ)
	
	var image = Image.new()
	image.load(path)
	
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	
	$ColorRect/TextureRect.texture = image_texture


func _on_confirm_pressed():
	if file != null && globalPath != '':
		var bytes = FileAccess.get_file_as_bytes(globalPath)
		var content = Marshalls.raw_to_base64(bytes)
		var payload = { "image": content }

		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.request_completed.connect(self._on_request_completed)
		
		var headers = ["Content-Type: application/json;"]
		var status = http_request.request(
			"http://localhost:8000/items",
			headers,
			HTTPClient.METHOD_POST,
			JSON.stringify(payload)
		)
		
		$LoadingScene.visible = true
		
		if status != OK:
			push_error("An error occurred in the HTTP request.")
		

func _on_request_completed(result, response_code, headers, body):
	$LoadingScene.visible = false
	$VBoxContainer.visible = false
	$Panel2.visible = false

	if response_code == 200:
		$Container/ResponseLabel.text = body.get_string_from_utf8()
	else:
		print("Request failed. Response code: ", response_code)
