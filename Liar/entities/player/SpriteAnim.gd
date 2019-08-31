extends Sprite

class_name SpriteAnim

onready var anim : AnimationPlayer = $AnimationPlayer
onready var anim_shoot : AnimationPlayer = $AnimationShoot

var frame_v : int = 0
var frame_h : int  = 0
var last_direction : String = "down"

func _ready():
	anim.play("idle_down")
	
func set_frame_v(frame : int):
	frame_v = frame
	update_frame()

func set_frame_h(frame : int):
	frame_h = frame
	update_frame()
	
func update_frame():
	frame = frame_v * self.hframes + frame_h

func _on_Player_change_move(direction : Vector2):
	match direction:
		Vector2(0,0):
			anim.play("idle_" + last_direction)
		Vector2(1,0):
			last_direction = "right"
			anim.play("walk_right")
		Vector2(-1,0):
			last_direction = "left"
			anim.play("walk_left")
		Vector2(0,1):
			last_direction = "down"
			anim.play("walk_down")
		Vector2(0,-1):
			last_direction = "up"
			anim.play("walk_up")
