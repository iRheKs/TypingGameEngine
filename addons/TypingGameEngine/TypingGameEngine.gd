tool
extends EditorPlugin

var controller_inspector

func _enter_tree():
	var gui = get_editor_interface().get_base_control()
	var load_icon = gui.get_icon("Node", "EditorIcons")
	add_custom_type("WordController", "Node", load("res://addons/TypingGameEngine/Scripts/WordController.gd"), load_icon)
	controller_inspector = load("res://addons/TypingGameEngine/Editor/WordControllerInspector.gd").new()
	add_inspector_plugin(controller_inspector)


func _exit_tree():
	remove_inspector_plugin(controller_inspector)
	remove_custom_type("WordController")
