extends Node2D

export var mainGameScene : PackedScene

func _on_NewGameButton_button_up():
	get_tree().change_scene(mainGameScene.resource_path)


func _on_QuitButton_button_up():
	get_tree().quit()
