extends Node3D
class_name base_door

@export_group("settings:")
@export_enum("open", "closed") var doorState: String = "closed"
@export var requiredClearance: int = 0
@export_group("nodes:")
@export var animationPlayer: AnimationPlayer
@export var detectionArea: Area3D

var isFirstInteraction: bool = true

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	connectSignals()
	if doorState == "open":
		animationPlayer.play("open")
	elif doorState == "closed":
		animationPlayer.play("closed")

func _process(delta: float) -> void:
	if detectionArea.overlaps_body(player):
		if Input.is_action_just_pressed("interact"):
			if PlayerData.ClearanceLevel >= requiredClearance:
				if doorState == "open":
					animationPlayer.play("closing")
					doorState = "closed"
				elif doorState == "closed":
					doorState = "open"
					animationPlayer.play("opening")

func connectSignals():
	animationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(name):
	if isFirstInteraction:
		if name == "opening" || name == "closing":
			useDoorToTrigger()

func useDoorToTrigger():
	isFirstInteraction = false
