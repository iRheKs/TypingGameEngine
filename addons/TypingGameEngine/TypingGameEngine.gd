tool
extends EditorPlugin


func _enter_tree():
	var gui = get_editor_interface().get_base_control()
	var load_icon = gui.get_icon("Node", "EditorIcons")
	add_custom_type("WordController", "Node", preload("Scripts/WordController.gd"), load_icon)


func _exit_tree():
	remove_custom_type("WordController")
