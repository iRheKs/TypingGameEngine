extends Control

# Exported member variables
export var text = "Word"
# "Private" member variables
var word_copy_unspaced = ""
var current_text = ""
var speed:float
var lifespan:float
var current_lifespan:float
var direction:int
# OnReady variables/nodes
onready var rb2D = get_node("RB2D")
onready var back_label = rb2D.get_node("Back")
onready var front_label = rb2D.get_node("Front")
onready var word_collision = rb2D.get_node("WordCollision")
# Word signals to be emitted
signal word_correct(word_text, word_node) #signal emitted when word is correctly entered
signal word_fail(word_text, word_node) #signal emitted when word is incorrectly entered
signal word_missed(word_text, word_node) #signal emitted when word is no longer available to be entered

# Called when the node enters the scene tree for the first time.
func _ready():
	back_label.text = text
	rb2D.linear_velocity = Vector2.ZERO
	set_collision_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rb2D.linear_velocity == Vector2.ZERO && direction > word_controller.DirectionEnum.STATIC:
		match direction:
			word_controller.DirectionEnum.UPWARDS:
				rb2D.set_linear_velocity(Vector2.UP * speed) 
			word_controller.DirectionEnum.DOWNWARDS:
				rb2D.set_linear_velocity(Vector2.DOWN * speed)
			word_controller.DirectionEnum.LEFT:
				rb2D.set_linear_velocity(Vector2.LEFT * speed)
			word_controller.DirectionEnum.RIGHT:
				rb2D.set_linear_velocity(Vector2.RIGHT * speed)
	elif direction == word_controller.DirectionEnum.STATIC:
		rb2D.set_linear_velocity(Vector2.ZERO)
	
	if text == current_text:
		emit_signal("word_correct", text, self)
		despawn_word()
	
	if lifespan > 0:
		if current_lifespan >= lifespan:
			emit_signal("word_missed", text, self)
			despawn_word()
			current_lifespan = 0
		else:
			current_lifespan += delta

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			current_text += " "
		elif event.scancode > 64 and event.scancode < 91:
			current_text += event.as_text()
			
		if text.begins_with(current_text):
			front_label.text = current_text
		else:
			emit_signal("word_fail", text, self)
			front_label.text = ""
			current_text = ""

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
	var label_size = back_label.get_font("font").get_string_size(text)
	back_label.rect_size = Vector2(label_size.x,label_size.y)
	
	var shape = RectangleShape2D.new()
	var extents_position = Vector2(label_size.x / 2, label_size.y / 2)
	
	shape.set_extents(extents_position)
	word_collision.set_shape(shape)
	word_collision.position = Vector2(extents_position)

func set_speed(_speed:float):
	speed = _speed * 10

func set_direction(_direction:int):
	direction = _direction

func set_text(_text:String):
	text = _text.to_upper()

func set_lifespan(_lifespan:float):
	lifespan =  _lifespan

func set_font_size(font_size:int):
	back_label.get_font("font").size = font_size

func set_font(font:Font):
	back_label.font = font
