extends Area2D



onready var text_box = get_node("../HUD/TextBox")
onready var sprite = $Sprite
export var explode : bool = false

func _on_FinalSwitch_body_entered(body):
	print(body.name)
	if body.is_in_group("player"):
		sprite.frame = 1
		if explode:
			body.explode()
		else: 
			get_tree().set_pause(true)
			text_box.write_text("Mission completed.")
			yield(text_box, "text_accepted")
			get_tree().set_pause(false)
		get_tree().change_scene("res://Test.tscn")


func _on_FinalSwitch_body_exited(body):
	if body.is_in_group("player"):
		sprite.frame = 0

