@icon("uid://h5ynnctommq1")
extends StaticBody3D
class_name _Object

#===============================================================================

@export var label: String
@export var isInteractive: bool = true

@export var isLocked: bool
@export var hasLighting: bool
@export var lighting: Light3D
@export var hasAnimation: bool
@export var animationPlayer: AnimationPlayer
@export var hasUsedUpMessage: bool
@export_multiline var usedUpMessage: String
@export var textDisplay: Label3D
@export var interface: _Interface

var message: String
var isPlayerInReach: bool = false
var showingMessage: bool = false
var isActive: bool = false
var isSelected: bool = false

const HIGHLIGHT = preload("uid://deyqjaxtfqq7j")

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var meshArray: Array = self.find_children("", "MeshInstance3D", true, false)

#===============================================================================



func _ready() -> void:
	intialSetup()
	conectSignals()

func _process(delta: float) -> void:
	handleTextDisplay()
	handleSelection()
	handleInteraction()

#===============================================================================

func intialSetup() -> void:
	interface.set_visible(false)
	interface.isLocked = isLocked
	textDisplay.set_modulate(ConfigSettings.interfaceTextColor)
	message = label
	textDisplay.set_text(message)
	textDisplay.set_visible(false)
	if hasLighting:
		lighting.set_color(ConfigSettings.interfaceLightingColor)
	if isInteractive:
		self.add_to_group("interactive")
	if isLocked:
		self.add_to_group("willAskForCode")



func conectSignals() -> void:
	animationPlayer.animation_finished.connect(_on_animation_finished)
	interface.interface_has_closed.connect(_on_interface_has_closed)

func _on_body_entered(body) -> void:
	if body == player:
		isPlayerInReach = true

func _on_body_exit(body) -> void:
	if body == player:
		isPlayerInReach = false
		showingMessage = false
		message = label
		textDisplay.set_text(message)

func handleTextDisplay() -> void:
	if !isPlayerInReach && !isActive:
		message = label
		textDisplay.set_text(message)
		showingMessage = false
	textDisplay.set_visible(isSelected && !isActive)

func handleInteraction() -> void:
	if isSelected:
		if Input.is_action_just_pressed("interact"):
			if isPlayerInReach:
				if !isActive:
					isActive = true
					PlayerData.hasControl = false
					textDisplay.set_visible(false)
					if hasAnimation:
						animationPlayer.play("activate")
			else:
				player.bark(StoryData.getOutOfReachMessage(), PlayerData.barkDuration)

func _on_animation_finished(anim) -> void:
	if anim == "activate":
		player.set_visible(false)
		interface.set_visible(true)
		interface.open()
	if anim == "deactivate":
		isActive = false

func _on_interface_has_closed() -> void:
	animationPlayer.play("deactivate")

func handleSelection():
	if meshArray.size() == 0:
		return
	if isSelected:
		for mesh in meshArray:
			mesh.set_material_overlay(HIGHLIGHT)
	else:
		for mesh in meshArray:
			mesh.set_material_overlay(null)
