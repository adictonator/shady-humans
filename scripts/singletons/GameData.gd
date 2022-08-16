extends Node

const FILE_PATH = 'res://data/ItemsData.json'
var data = {}
var json = JSON.new()

func _ready() -> void:
	var dataFile = File.new()
	dataFile.open(FILE_PATH, File.READ)

	#var jsonData = json.parse(dataFile.get_as_text())
	var error = json.parse(dataFile.get_as_text())

	if error == OK:
		var data_received = json.get_data()
		if typeof(data_received) == TYPE_ARRAY:
			data = data_received
			print(data_received) # Prints array
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in at line ", json.get_error_line())

	dataFile.close()

