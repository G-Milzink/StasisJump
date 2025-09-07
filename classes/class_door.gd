@icon("uid://duaa4aygnhcyo") 
extends Node3D
class_name _Door

@export_group("settings:")
@export_enum("open", "closed") var doorState: String = "closed"
@export var requiredClearance: int = 0
@export_group("nodes:")
@export var animationPlayer: AnimationPlayer
@export var detectionArea: Area3D

var isFirstInteraction: bool = true

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _ready() -> void:
	connectSignals()
	handleInitalDoorState()

func _process(delta: float) -> void:
	if detectionArea.overlaps_body(player):
		if Input.is_action_just_pressed("interact"):
			if PlayerData.ClearanceLevel >= requiredClearance:
				handleDynamicDoorState()

#===============================================================================

func connectSignals():
	animationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim):
	if isFirstInteraction:
		if anim == "opening" || anim == "closing":
			useDoorToTrigger()

func useDoorToTrigger():
	isFirstInteraction = false

func handleInitalDoorState():
	if doorState == "open":
		animationPlayer.play("open")
	elif doorState == "closed":
		animationPlayer.play("closed")

func handleDynamicDoorState():
	if doorState == "open":
		doorState = "closed"
		animationPlayer.play("closing")
	elif doorState == "closed":
		doorState = "open"
		animationPlayer.play("opening")
