extends Control

# Exported member variables
export var text = "Word"
# "Private" member variables
var _word_copy_unspaced = ""
var _current_text = ""
var _speed:float
var _lifespan:float
var _current_lifespan:float
var _direction:int
# OnReady variables/nodes
onready var _rb2D = get_node("RB2D")
onready var _back_label = _rb2D.get_node("Back")
onready var _front_label = _rb2D.get_node("Front")
onready var _word_collision = _rb2D.get_node("WordCollision")
# Word signals to be emitted
signal word_correct(word_text, word_node) #signal emitted when word is correctly entered
signal word_fail(word_text, word_node) #signal emitted when word is incorrectly entered
signal word_missed(word_text, word_node) #signal emitted when word is no longer available to be entered

# Called when the node enters the scene tree for the first time.
func _ready():
	_back_label.text = text
	_rb2D.linear_velocity = Vector2.ZERO
	set_collision_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _rb2D.linear_velocity == Vector2.ZERO && _direction > WordController.DirectionEnum.STATIC:
		match _direction:
			WordController.DirectionEnum.UPWARDS:
				_rb2D.set_linear_velocity(Vector2.UP * _speed) 
			WordController.DirectionEnum.DOWNWARDS:
				_rb2D.set_linear_velocity(Vector2.DOWN * _speed)
			WordController.DirectionEnum.LEFT:
				_rb2D.set_linear_velocity(Vector2.LEFT * _speed)
			WordController.DirectionEnum.RIGHT:
				_rb2D.set_linear_velocity(Vector2.RIGHT * _speed)
	elif _direction == WordController.DirectionEnum.STATIC:
		_rb2D.set_linear_velocity(Vector2.ZERO)
	
	if text == _current_text:
		emit_signal("word_correct", text, self)
		despawn_word()
	
	if _lifespan > 0:
		if _current_lifespan >= _lifespan:
			emit_signal("word_missed", text, self)
			despawn_word()
			_current_lifespan = 0
		else:
			_current_lifespan += delta

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			_current_text += " "
		elif event.scancode > 64 and event.scancode < 91:
			_current_text += event.as_text()
			
		if text.begins_with(_current_text):
			_front_label.text = _current_text
		else:
			emit_signal("word_fail", text, self)
			_front_label.text = ""
			_current_text = ""

func despawn_word():
	set_physics_process(false)
	set_process(false)
	set_process_input(false)
	visible = false

func respawn_word():
	set_physics_process(true)
	set_process(true)
	set_process_input(true)
	visible = true

func set_collision_size():
	var label_size = _back_label.get_font("font").get_string_size(text)
	_back_label.rect_size = Vector2(label_size.x,label_size.y)
	
	var shape = RectangleShape2D.new()
	var extents_position = Vector2(label_size.x / 2, label_size.y / 2)
	
	shape.set_extents(extents_position)
	_word_collision.set_shape(shape)
	_word_collision.position = Vector2(extents_position)

func set_speed(_speed:float):
	self._speed = _speed * 10

func set_direction(_direction:int):
	self._direction = _direction

func set_text(_text:String):
	self.text = _text.to_upper()
	_back_label.text = text

func set_lifespan(_lifespan:float):
	self._lifespan =  _lifespan

func set_font_size(font_size:int):
	_back_label.get_font("font").size = font_size
	_front_label.get_font("font").size = font_size

func set_font(font:Font):
	_back_label.add_font_override("font",font)
	_front_label.add_font_override("font",font)
