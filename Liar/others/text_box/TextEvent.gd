extends Area2D

export var text_entries : PoolStringArray
export var disable_afterwards : bool = true
var disabled : bool = false
var text_box : TextBox
var parent

func _ready():
	text_box = get_node("../HUD/TextBox")
	parent = get_parent()

func _on_TextEvent_body_entered(body):
	if not disabled and body.is_in_group("player"):
		get_tree().set_pause(true)
		for text in text_entries:
			text_box.write_text(text)
			yield(text_box, "text_accepted")
		get_tree().set_pause(false)
		if disable_afterwards:
			disabled = true