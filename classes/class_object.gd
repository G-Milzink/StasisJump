@icon("uid://h5ynnctommq1")
extends Node3D
class_name _Object

#===============================================================================

@export var label: String
@export var storyArea: String
@export var isLocked: bool
@export var hasLighting: bool
@export var lighting: Light3D
@export var hasAnimation: bool
@export var animationPlayer: AnimationPlayer
@export var hasUsedUpMessage: bool
@export_multiline var usedUpMessage: String
@export var detectionArea: Area3D
@export var textDisplay: Label3D
@export var interface: _Interface

var message: String
var playerInRange: bool = false
var showingMessage: bool = false
var isActive: bool = false

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _enter_tree() -> void:
	propagate_call("setStoryAreaFrom_Object", [storyArea], true)

func _ready() -> void:
	intialSetup()
	conectSignals()

func _process(delta: float) -> void:
	handleTextDisplay()
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
	interface.storyArea = storyArea

func setStoryAreaFrom_Object(area: String) -> void:
	storyArea = area

func conectSignals() -> void:
	detectionArea.body_entered.connect(_on_body_entered)
	detectionArea.body_exited.connect(_on_body_exit)
	animationPlayer.animation_finished.connect(_on_animation_finished)
	interface.interface_has_closed.connect(_on_interface_has_closed)

func _on_body_entered(body) -> void:
	if body == player:
		playerInRange = true

func _on_body_exit(body) -> void:
	if body == player:
		playerInRange = false
		showingMessage = false
		message = label
		textDisplay.set_text(message)

func handleTextDisplay() -> void:
	textDisplay.set_visible(playerInRange)

func handleInteraction() -> void:
	if playerInRange && Input.is_action_just_pressed("interact"):
		if !isActive:
			isActive = true
			PlayerData.hasControl = false
			if hasAnimation:
				animationPlayer.play("activate")

func _on_animation_finished(anim) -> void:
	if anim == "activate":
		player.set_visible(false)
		interface.set_visible(true)
		interface.open()
	if anim == "deactivate":
		isActive = false

func _on_interface_has_closed() -> void:
	animationPlayer.play("deactivate")
