extends Node2D

export var max_objects : int = 10

var number_objects : int = 0 
func _ready():
	randomize()
	for child in get_children():
		if number_objects == max_objects:
			break
		var rand = randi()%2+1
		print(rand)
		if rand == 1:
			child.queue_free()
		else:
			number_objects = number_objects + 1
	print(number_objects)

func get_number_objects() -> int:
	return number_objects