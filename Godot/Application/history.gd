extends Control

var itemList
var scene = load("res://Application/button_template.tscn")

func _ready():
	getItemList()


func generateItemList():
	for item in itemList:
		var instance = scene.instantiate()
		$ScrollContainer/VBoxContainer.add_child(instance)
		instance.setup(item)
		

func getItemList():

	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)
	
	var headers = ["Content-Type: application/json;"]
	var status = http_request.request(
		"http://localhost:8000/items",
		headers,
		HTTPClient.METHOD_GET
	)

	
	if status != OK:
		push_error("An error occurred in the HTTP request.")
		
func _on_request_completed(result, response_code, headers, body):
	$LoadingScene.visible = false
	if response_code == 200:
		var res = JSON.parse_string(body.get_string_from_utf8())
		var data = JSON.parse_string(res)
		
		itemList = data
		
		generateItemList()		
	else:
		print("Request failed. Response code: ", response_code)
