extends KinematicBody2D

var target_position:Vector2 = Vector2.ZERO
var speed = 500

func _ready():
	pass

func _physics_process(delta):
	if(target_position != Vector2.ZERO):
		var collision_info = move_and_collide(self.position.direction_to(target_position) * speed * delta)
		if(collision_info):
			collision_info.collider.free()
			queue_free()

func set_target(target:Vector2):
	target_position = target
