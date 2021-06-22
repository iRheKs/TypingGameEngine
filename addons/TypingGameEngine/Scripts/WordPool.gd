extends Node

var _pool_size = 0
var _word_pool:Array
var _word_reference

func _ready():
	print("pooling: ", _pool_size, " words")
	for i in range(_pool_size):
		var word_instance = _word_reference.instance()
		word_instance.despawn_word()
		_word_pool.push_back(word_instance)
		add_child(word_instance)

func get_word():
	var next_available = null
	for i in range(_word_pool.size()):
		if not _word_pool[i].visible:
			next_available = _word_pool[i]
			return next_available
	if next_available == null:
		var word_instance = _word_reference.instance()
		word_instance.despawn_word()
		_word_pool.push_back(word_instance)
		add_child(word_instance)
		return word_instance

func set_pool_size(size:int):
	_pool_size = size

func set_word_reference(word):
	_word_reference = word
