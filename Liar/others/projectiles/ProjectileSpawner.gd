extends Node2D

signal shoot
signal upgradeShoot

onready var anim_shoot : AnimationPlayer = get_node("../SpriteAnim/AnimationShoot")
onready var cooldown_timer = $CooldownTimer
onready var charge_timer = $ChargeTimer

var projectile = preload("Projectile.tscn")
var isShooting = false
var new_bullet



func _physics_process(delta):
	if isShooting:
		if new_bullet != null:
			new_bullet.position = position
		if Input.is_action_pressed("attack"):
			if charge_timer.is_stopped():
				if new_bullet.currentLevel < 4:
					charge_timer.start()
				else:
					fire()
		else:
			fire()

func _input(event):
	if !isShooting:
		if event.is_action_pressed("attack") and owner.look_direction != Vector2():
			startFire()

func startFire():
	if not cooldown_timer.is_stopped():
		return
	anim_shoot.play("shoot")
	yield(anim_shoot, "animation_finished")
	new_bullet = projectile.instance()
	new_bullet.position = position
	new_bullet.call_deferred("nextCharge")
	get_parent().add_child(new_bullet)
	isShooting = true

func fire():
	if !charge_timer.is_stopped():
		charge_timer.stop()
	isShooting = false
	new_bullet.fire()
	new_bullet.direction = owner.look_direction
	anim_shoot.play_backwards("shoot")
	cooldown_timer.start()
	yield(anim_shoot, "animation_finished")
	anim_shoot.play_backwards("idle")

func _on_ChargeTimer_timeout():
	new_bullet.nextCharge()
