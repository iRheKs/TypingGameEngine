class_name word_controller
extends Node

# Enumerator for the direction which the word is moving
enum DirectionEnum {UPWARDS, DOWNWARDS, LEFT, RIGHT, STATIC = -1}

var word_prefab = load("res://addons/TypingGameEngine/Prefabs/Word.tscn")

# Exported word variables
export(Font) var word_font = preload("res://addons/TypingGameEngine/FontResources/defaultFont.tres")
export(int) var word_size = 100
# Signals emitted by the controller (signals comming from each word)
signal word_finished(word_text)
signal word_missed(word_text)
signal word_failed(word_text)

func _enter_tree():
	print("Word Controller created")

func _ready():
	pass
#	new_word("hola",Vector2 (100,0),DirectionEnum.STATIC, 20)
#	new_word("mundo",Vector2 (100,100),DirectionEnum.STATIC, 20)
#	new_word("como va",Vector2 (100,200),DirectionEnum.STATIC, 20)

# This method creates a new word with:
# 	word_text:String = the word/text you want to set
# 	position:Vector2 = the position(global) where the word will be spawned
# 	direction:DirectionEnum = the enumerator for the direction the word will be moving. STATIC as default
# 	speed:float = the speed which the word will be moving, multiplied by 10. 0 as default
# 	lifespan:float = the life time the word will be in available in seconds, 0 is infinite. 0 as default
func new_word(word_text:String, position:Vector2, direction:int = DirectionEnum.STATIC, speed:float = 0, lifespan:float = 0):
	var word_prefab_instance = word_prefab.instance()
	word_prefab_instance.set_font(word_font)
	word_prefab_instance.set_font_size(word_size)
	word_prefab_instance.set_text(word_text)
	word_prefab_instance.set_global_position(position)
	word_prefab_instance.set_direction(direction)
	word_prefab_instance.set_speed(speed)
	word_prefab_instance.set_lifespan(lifespan)
	connect_word_signals(word_prefab_instance)
	add_child(word_prefab_instance)

func connect_word_signals(word_prefab_instance):
	word_prefab_instance.connect("word_correct", self, "_on_word_finished")
	word_prefab_instance.connect("word_missed", self, "_on_word_unfinished")
	word_prefab_instance.connect("word_fail", self, "_on_word_failed")

func _on_word_finished(word_text:String, word:Control):
	emit_signal("word_finished", word_text)
	print("word: ", word_text,", obj: ", word, ", FINISHED")

func _on_word_missed(word_text:String, word:Control):
	emit_signal("word_missed", word_text)
	print("word: ", word_text," obj: ", word, ", MISSED")

func _on_word_failed(word_text:String, word:Control):
	emit_signal("word_failed", word_text)
	print("word: ", word_text," obj: ", word, ", FAILED")
