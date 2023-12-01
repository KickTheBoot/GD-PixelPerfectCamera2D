@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("PixelPerfectCamera2D","Camera2D",preload("PixelPerfectCamera.gd"),preload("icon.svg"))

func _exit_tree():
	remove_custom_type("PixelPerfectCamera2D")
