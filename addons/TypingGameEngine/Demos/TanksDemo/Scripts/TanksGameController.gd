extends Node

onready var word_controller = $WordController
onready var enemy_tank_1 = $EnemyTank_1
onready var enemy_tank_2 = $EnemyTank_2
onready var player = $PlayerTank

signal player_shot(enemy_pos)
signal enemy_shot(player_pos, word)
signal game_over()

func _ready():
	word_controller.connect("word_finished", self, "_on_WordController_word_finished")
	word_controller.connect("word_failed", self, "_on_WordController_word_failed")
	word_on_enemy(enemy_tank_1, enemy_tank_1.word)
#	word_on_player()
	
#	Check before trying to shoot an enemy whether it exists or not
func _on_WordController_word_finished(word_text:String):
	if (is_instance_valid(enemy_tank_1) and word_text == enemy_tank_1.word):
			player_shoots(enemy_tank_1.position)
#			after shooting one enemy, the second enemy word is instanced so words don't overlap and second tank kills the player
			word_on_enemy(enemy_tank_2, enemy_tank_2.word)
	elif(is_instance_valid(enemy_tank_2) and (word_text == enemy_tank_2.word)):
		player_shoots(enemy_tank_2.position)

func _on_WordController_word_failed(word_text:String):
	enemy_shoots(player.position, word_text)

func player_shoots(enemy_pos:Vector2):
	emit_signal("player_shot", enemy_pos)

func enemy_shoots(player_pos:Vector2, word:String):
	emit_signal("enemy_shot", player_pos, word)

func word_on_enemy(enemy:Node2D, word:String):
	var word_position = Vector2(enemy.position.x - 35, enemy.position.y - 70)
	word_controller.new_word(word,word_position)

func word_on_player():
	var word_position = Vector2(player.position.x - 35, player.position.y - 70)
	word_controller.new_word("TEST",word_position, {direction = word_controller.DirectionEnum.FOLLOWER, target = player, offset = Vector2(-35,-70)})

func game_over():
	$GameOverLabel.visible = true
	emit_signal("game_over")
	word_controller.despawn_words()


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
