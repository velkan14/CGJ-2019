extends Area2D

export var text_entries : PoolStringArray
export var disable_afterwards : bool = true
var disabled : bool = false
var text_box : TextBox
var parent
var lying

onready var doors = get_node("../DoorHolder")
onready var enemies = get_node("../EnemyHolder")
onready var lights = get_node("../LightHolder")

func _ready():
	text_box = get_node("../HUD/TextBox")
	parent = get_parent()
	var rand = randi()%2+1
	if rand == 1:
		lying = true
	else:
		lying = false

func _on_LastEvent_body_entered(body):
	if not disabled and body.is_in_group("player"):
		get_tree().set_pause(true)
		var rand = randi()%3+1
		var text = ""
		match rand:
			1:
				var number = randi()%13+1
				if not lying:
					number =  doors.get_number_objects()
				text = str("So many doors! Where you able to open all ", number," doors?")
			2:
				var number = randi()%22+1
				if not lying:
					number =  enemies.get_number_objects()
				text = str("So many enemies! Where you able to kill all ",number ,"?")
			3:
				var number = randi()%18+1
				if not lying:
					number =  lights.get_number_objects()
				text = str("So many lights! Did you get blinded by the ",number ," lights existing?")
		text_box.write_text(text)
		yield(text_box, "text_accepted")
		if lying:
			text_box.write_text("You should go to the left to finish the level.")
		else:
			text_box.write_text("You should go to the right to finish the level.")
		yield(text_box, "text_accepted")
		get_tree().set_pause(false)
		if disable_afterwards:
			disabled = true
