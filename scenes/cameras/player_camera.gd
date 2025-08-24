extends Node3D

var player: CharacterBody3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")



func _process(delta: float) -> void:
	if player:
		position = player.position
