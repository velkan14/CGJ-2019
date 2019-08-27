extends Area2D

export var text : String = ""
var text_box : TextBox
var parent

func _ready():
	text_box = get_node("../HUD/TextBox")
	parent = get_parent()
	
func _on_TextEvent_body_entered(body):
	if body.is_in_group("player"):
		get_tree().set_pause(true)
		text_box.write_text(text)
		yield(text_box, "text_accepted")
		get_tree().set_pause(false)