extends KinematicBody2D

signal died()

onready var nav2d : Navigation2D = get_node("../Navigation2D")
onready var tile_map : TileMap = get_node("../Navigation2D/TileMap")

var speed : = 200.0
var path : = PoolVector2Array() setget set_path
var moveDir : Vector2 = Vector2()
var target  

func _ready():
	set_process(false)

func get_path():
	var path_temp = nav2d.get_simple_path(position, target.position)
	var arr = PoolVector2Array()
	for p in path_temp:
		var cell = tile_map.world_to_map(p)
		arr.append(tile_map.map_to_world(cell) - Vector2(12,12))
	set_path(arr)
	

func _process(delta: float) -> void:
	var move_distance : = speed * delta
	move_along_path(move_distance)
	
#func _physics_process(delta):
#	var difference : Vector2 = path[0] - position
#	if path[0].distance_to(position) < 25:
#		path.remove(0)
#	move_and_slide(difference)


func move_along_path(distance : float) -> void:
	var last_point : = position
	for index in range(path.size()):
		var distance_to_next = last_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = last_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif path.size() == 1 and distance >= distance_to_next:
			position = path[0]
			set_process(false)
			break

		distance -= distance_to_next
		last_point = path[0]
		path.remove(0)


func set_path(value : PoolVector2Array) -> void:
	if value.size() == 0:
		return
	path = value
	path.remove(0)
	set_process(true)


func _on_Timer_timeout():
	get_path()
