extends Node
class_name WordController

# Enumerator for the direction which the word is moving
enum DirectionEnum {UPWARDS, DOWNWARDS, LEFT, RIGHT, STATIC = -1}

var _word_prefab = load("res://addons/TypingGameEngine/Prefabs/Word.tscn")

var _word_pool
# Exported word variables
# The font the words are going to use
export(Font) var word_font = preload("res://addons/TypingGameEngine/FontResources/defaultFont.tres")
# TODO: add the posibility to change the current_word color
# Color of the words to be instantiated
export(Color) var word_color = Color.white
# Size of the words to be instantiated
export(int, 10, 100, 1) var word_size = 100
# Size of the word pool, how many words will be created at the ready function
export(int, 10, 100, 1) var pool_size = 10

# Signals emitted by the controller (signals comming from each word)
signal word_finished(word_text)
signal word_missed(word_text)
signal word_failed(word_text)

func _enter_tree():
	print("Word Controller created")

func _ready():
	_start_pool()
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
	var word_prefab_instance = _word_pool.get_word()
	_set_word_properties(word_prefab_instance, word_font, word_size, word_color, word_text, position, direction, speed, lifespan)
	_connect_word_signals(word_prefab_instance)
	word_prefab_instance.respawn_word()

# This method creates a new word with a custom font:
# 	word_text:String = the word/text you want to set
# 	position:Vector2 = the position(global) where the word will be spawned
# 	direction:DirectionEnum = the enumerator for the direction the word will be moving. STATIC as default
# 	speed:float = the speed which the word will be moving, multiplied by 10. 0 as default
# 	lifespan:float = the life time the word will be in available in seconds, 0 is infinite. 0 as default
# 	_word_size:int = the word size you want to set to this specific word, 10 as default
# 	_word_color:Color = the word color you want to set to this specific word, Color.white as default
# 	_word_font:Font = the word font you want to set to this specific word, defaultFont.tres as default located in addon resources folder
func new_word_custom_font(_word_text:String, _position:Vector2, _direction:int = DirectionEnum.STATIC, _speed:float = 0, _lifespan:float = 0, _word_size:int = 10, _word_color:Color = Color.white, _word_font:Font = load("res://addons/TypingGameEngine/FontResources/defaultFont.tres").new()):
	word_font = _word_font
	word_size = _word_size
	word_color = _word_color
	new_word(_word_text, _position, _direction, _speed, _lifespan)

# This method can be used to despawn all words in the pool in case they have an infinite lifespan
func despawn_words():
	_word_pool.despawn_words()

func _set_word_properties(_word_prefab_instance, _word_font:Font, _word_size:int, _word_color:Color, _word_text:String, _position:Vector2, _direction:int, _speed:float, _lifespan:float):
	_word_prefab_instance.set_font(_word_font)
	_word_prefab_instance.set_font_size(_word_size)
	_word_prefab_instance.set_word_color(_word_color)
	_word_prefab_instance.set_text(_word_text)
	_word_prefab_instance.set_speed(_speed)
	_word_prefab_instance.set_direction(_direction)
	_word_prefab_instance.set_lifespan(_lifespan)
	_word_prefab_instance.set_word_position(_position)
	_word_prefab_instance.set_collision_size()

func _start_pool():
	if _word_pool == null:
		_word_pool = load("res://addons/TypingGameEngine/Scripts/WordPool.gd").new()
		_word_pool.set_pool_size(pool_size)
		_word_pool.set_word_reference(_word_prefab)
		add_child(_word_pool)

func _connect_word_signals(word_prefab_instance):
	if not(word_prefab_instance.is_connected("word_correct",self,"_on_Word_finished")):
		word_prefab_instance.connect("word_correct", self, "_on_Word_finished")
	if not(word_prefab_instance.is_connected("word_missed",self,"_on_Word_missed")):
		word_prefab_instance.connect("word_missed", self, "_on_Word_missed")
	if not(word_prefab_instance.is_connected("word_fail",self,"_on_Word_failed")):
		word_prefab_instance.connect("word_fail", self, "_on_Word_failed")

func _on_Word_finished(word_text:String, word:Control):
	emit_signal("word_finished", word_text)
	print("word: ", word_text,", obj: ", word, ", FINISHED")

func _on_Word_missed(word_text:String, word:Control):
	emit_signal("word_missed", word_text)
	print("word: ", word_text,", obj: ", word, ", MISSED")

func _on_Word_failed(word_text:String, word:Control):
	emit_signal("word_failed", word_text)
	print("word: ", word_text,", obj: ", word, ", FAILED")
