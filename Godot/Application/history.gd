extends Control

var itemList
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # bd


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getItemList():
	pass
	#var bytes = FileAccess.get_file_as_bytes(globalPath)
	#var content = Marshalls.raw_to_base64(bytes)
	#var payload = { "image": content }
#
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
	#http_request.request_completed.connect(self._on_request_completed)
	#
	#var headers = ["Content-Type: application/json;"]
	#var status = http_request.request(
		#"http://localhost:8000/items",
		#headers,
		#HTTPClient.METHOD_POST,
		#JSON.stringify(payload)
	#)
	#
	#if status != OK:
		#push_error("An error occurred in the HTTP request.")
