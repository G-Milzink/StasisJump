@icon("uid://duaa4aygnhcyo") 
extends Area3D
class_name _Door

@export_group("settings:")
@export_enum("open", "closed") var doorState: String = "closed"
@export var requiredClearance: int = 0
@export_group("nodes:")
@export var animationPlayer: AnimationPlayer

var isFirstInteraction: bool = true
var isSelected: bool = false
var isPlayerInReach: bool = false

const HIGHLIGHT = preload("uid://deyqjaxtfqq7j")

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var meshArray: Array = self.find_children("", "MeshInstance3D", true, false)

#===============================================================================

func _ready() -> void:
	self.add_to_group("interactive")
	connectSignals()
	handleInitalDoorState()

func _process(delta: float) -> void:
	handleSelection()
	handleInteraction()
	

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

func handleSelection():
	if meshArray.size() == 0:
		return
	if isSelected:
		for mesh in meshArray:
			mesh.set_material_overlay(HIGHLIGHT)
	else:
		for mesh in meshArray:
			mesh.set_material_overlay(null)

func handleInteraction():
	if Input.is_action_just_pressed("interact"):
		if isSelected:
			if isPlayerInReach:
				if PlayerData.ClearanceLevel >= requiredClearance:
					handleDynamicDoorState()
				else:
					player.bark(StoryData.getNoClearanceMessage(), PlayerData.barkDuration)
			else:
				player.bark(StoryData.getOutOfReachMessage(), PlayerData.barkDuration)
