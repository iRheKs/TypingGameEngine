extends KinematicBody2D
class_name Tank

onready var tank_controller = $".."

var _bullet_prefab = load("res://addons/TypingGameEngine/Demos/TanksDemo/Resources/Prefabs/TankBullet.tscn")
var player:bool
export (int) var speed = 200
var target = Vector2()
var velocity = Vector2()
var distance = 0.0
onready var moving:bool = false

func _ready():
	player = true
	target = self.global_position
	tank_controller.connect("player_shot", self, "_on_player_shot")
	tank_controller.connect("game_over",self,"_on_game_over")

func _input(event):
# if you want to use this code, make sure to have a mouse click action in input configuration
#	if player:
#		if event.is_action_pressed("click"):
#			target = get_global_mouse_position()
#			look_at(target)
	pass

func _physics_process(_delta):
	if player:
		velocity = position.direction_to(target) * speed
		if position.distance_to(target) > 5:
			velocity = move_and_slide(velocity)
			moving = true
		elif moving:
			moving = false

func _on_player_shot(other_position:Vector2):
	shoot(other_position)

func shoot(other_position:Vector2):
	self.look_at(other_position)
	var bullet = _bullet_prefab.instance()
	tank_controller.add_child(bullet)
	bullet.position = Vector2(self.position.x + 75 * self.position.direction_to(other_position).x, self.position.y)
	bullet.set_target(other_position)
	bullet.look_at(other_position)

func _exit_tree():
	if(self.player):
		tank_controller.game_over()

func _on_game_over():
	tank_controller.disconnect("player_shot",self,"_on_player_shot")
