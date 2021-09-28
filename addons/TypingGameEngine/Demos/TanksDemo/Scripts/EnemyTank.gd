extends Tank

export(String) var word = "HelloWorld"

func _ready():
	player = false
	word = word.to_upper()
	tank_controller.connect("enemy_shot", self, "_on_enemy_shot")
	tank_controller.disconnect("player_shot", self, "_on_player_shot")

func _on_enemy_shot(other_position:Vector2, word:String):
	if (self.word == word):
		shoot(other_position)

func _on_game_over():
	tank_controller.disconnect("enemy_shot",self,"_on_enemy_shot")
