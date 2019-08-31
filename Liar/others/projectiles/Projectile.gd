extends KinematicBody2D

onready var anim : AnimationPlayer = $Sprite/AnimationPlayer
onready var hitbox_collision : CollisionShape2D = $HitBox/CollisionShape2D

var direction = Vector2()
export(float) var SPEED = 1000.0

var currentLevel = 0
var isMoving = false

func _ready():
	hitbox_collision.disabled = true
	set_process(false)

func _physics_process(delta):
	if isMoving:
		var collision_info = move_and_slide(direction * SPEED)

func _on_HitBox_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(1)
		print(body.name)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	print("exit")
	#queue_free()

func nextCharge():
	if currentLevel < 4:
		currentLevel += 1
		var level = "level" + str(currentLevel)
		anim.play(level)

func fire():
	set_as_toplevel(true)
	print(get_parent().position)
	position = get_parent().position 
	hitbox_collision.disabled = false
	isMoving = true
	set_process(true)