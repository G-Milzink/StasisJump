extends Node3D
class_name base_prop

@export_group("Settings:")
@export var popup: String = "a prop"
@export var hasDescription: bool 
@export var description: String = "MAIN DESCRIPTION GOES HERE."
@export var hasRepeatMessage: bool
@export var repeatMessage: String = "IMPORTANT STUFF REPEATS HERE"
@export_group("Nodes:")
@export var detectionArea: Area3D
@export var popupLabel: Label3D
@export var descriptionLabel: Label3D

var isFirstInteraction: bool = true
var isActive: bool = false

const noDescription: Array = PropData.uselessPropDescriptions

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _ready() -> void:
	popupLabel.set_text(popup)
	popupLabel.visible = false
	descriptionLabel.visible = false

func _process(delta: float) -> void:
	setInformation()
	showInformation()

#===============================================================================

func setInformation():
	if detectionArea.overlaps_body(player):
		if Input.is_action_just_pressed("interact") && !isActive:
			isActive = true
			if hasDescription && isFirstInteraction:
				isFirstInteraction = false
				descriptionLabel.set_text(description)
			elif hasRepeatMessage: 
				descriptionLabel.set_text(repeatMessage)
			else:
				descriptionLabel.set_text(noDescription[randi_range(0, noDescription.size()-1)])
	else:
		isActive = false

func showInformation():
	if detectionArea.overlaps_body(player):
		if!descriptionLabel.visible:
			if !popupLabel.visible:
				popupLabel.visible = true
		else:
			if popupLabel.visible:
				popupLabel.visible = false
		if Input.is_action_just_pressed("interact"):
			descriptionLabel.visible = true
	else:
		popupLabel.visible = false
		descriptionLabel.visible = false
