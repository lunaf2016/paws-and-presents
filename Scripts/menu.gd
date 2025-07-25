extends Control


func _ready():
	pass

func _on_start_button_pressed():
	get_tree().change_file_to_scene("res://scenes/Level_1.tscn")
