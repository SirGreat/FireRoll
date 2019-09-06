extends Node

var BUSH = preload("res://Map/Objects/Bush.tscn")

var cellSize

func _ready():
	$"Bushes/Player".position = $"Player Spawn".position
	cellSize = $Bushes.cell_size
	replaceWithScenes()
	
	
	
func replaceWithScenes():
	# Get ids
	var ids = $Bushes.get_used_cells_by_id(0)
	#print (ids)
	# Loop through and calculate where to instance
	for id in ids:
		var bush = BUSH.instance()
		var spawnPos = Vector2()
		spawnPos.x = id.x * cellSize.x + cellSize.x / 2
		spawnPos.y = id.y * cellSize.y + cellSize.y / 2
		bush.position = spawnPos
		add_child(bush)
		
	
