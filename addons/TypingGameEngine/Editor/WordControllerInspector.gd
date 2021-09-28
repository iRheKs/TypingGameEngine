tool
extends EditorInspectorPlugin

func can_handle(object):
	return object is WordController

func parse_property(object, type, property_name, hint, hint_text, usage):
	if(property_name == "word_font" or property_name == "pool_size" or property_name == "word_size" or property_name == "word_color"):
		return false
	return true
