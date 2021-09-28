extends KinematicBody2D
class_name Tank

onready var tank_controller = $".."

var _bullet_prefab = load("res://addons/TypingGameEngine/Demos/TanksDemo/Resources/Prefabs/TankBullet.tscn")
var player:bool

func _ready():
	player = true
	tank_controller.connect("player_shot", self, "_on_player_shot")
	tank_controller.connect("game_over",self,"_on_game_over")

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
