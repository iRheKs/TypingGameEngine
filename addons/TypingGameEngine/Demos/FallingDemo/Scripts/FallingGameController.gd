extends Node

export(float) var spawn_cooldown = 5
export(float) var word_lifespan = 1
export(float) var word_speed = 1

export(Array, String) var word_list

var score:int = 0
var current_spawn_cooldown:float = 0

onready var word_controller = $WordController
onready var score_label = $ScoreLabel
onready var missed_word_label = $MissedWordLabel

func _ready():
	word_controller.connect("word_finished", self, "_on_WordController_word_finished")
	word_controller.connect("word_missed", self, "_on_WordController_word_missed")
	
	current_spawn_cooldown = spawn_cooldown

func _process(delta):
	if current_spawn_cooldown >= spawn_cooldown:
		var random_word_index = rand_range(0, word_list.size()-1)
		word_controller.new_word(word_list[random_word_index], get_random_position(word_list[random_word_index]), word_controller.DirectionEnum.DOWNWARDS, word_speed, word_lifespan)
		current_spawn_cooldown = 0
	else:
		current_spawn_cooldown += delta

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()

func get_random_position(word_text:String):
	var word_size = word_controller.word_font.get_string_size(word_text)
	var viewport_rect = get_viewport().get_visible_rect()
	var random_x_position = rand_range(0, viewport_rect.size.x-word_size.x)
	var random_y_position = rand_range(0, viewport_rect.size.y-word_size.y)
	return Vector2(random_x_position,random_y_position)

func _on_WordController_word_finished(word_text:String):
	score += 1
	score_label.text = "Score: " + score as String

func _on_WordController_word_missed(word_text:String):
	missed_word_label.text = "Last missed: " + word_text
