extends Node

const FILE_PATH = 'res://data/ItemsData.json'
var data = {}

func _ready() -> void:
	var dataFile = File.new()
	dataFile.open(FILE_PATH, File.READ)

	var jsonData = JSON.parse(dataFile.get_as_text())
	dataFile.close()

	data = jsonData.result