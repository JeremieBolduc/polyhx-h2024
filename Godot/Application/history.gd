extends Control

var itemList

func _ready():
	getItemList()

func getItemList():
	print("start")
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)
	
	var headers = ["Content-Type: application/json;"]
	var status = http_request.request(
		"http://localhost:8000/items",
		headers,
		HTTPClient.METHOD_GET
	)
	print("requested")
	
	if status != OK:
		push_error("An error occurred in the HTTP request.")
		
func _on_request_completed(result, response_code, headers, body):
	print("completed")
	if response_code == 200:
		print(body.get_string_from_utf8())
	else:
		print("Request failed. Response code: ", response_code)
