extends Node3D
class_name base_object

@export_group("Settings:")
@export var popup: String = "an object"
@export var hasAction: bool
@export var hasActionDescription: bool
@export var hasActionAnimation: bool
@export var actionDescription: String = "ACTION DESCRIPTION HERE"
@export var actionIsRepeatable: bool
@export var hasResetAnimation: bool
@export var hasInterface: bool
@export var interfaceDescription: String = "INTERFACE DESCRIPTION HERE"
@export_group("Nodes:")
@export var detectionArea: Area3D
@export var popupLabel: Label3D
@export var descriptionLabel: Label3D
@export var actionPlayer: AnimationPlayer
@export var interface: Node3D
@export var interfaceCamera: Camera3D

var canPerformAction: bool = true
var isInterfaceOpen: bool = false
var isInterfaceActionPerformed: bool = false

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _ready() -> void:
	setInfo()
	connectSignals()
	

func _process(delta: float) -> void:
	showInfo()
	handleInteraction()

#===============================================================================

func handleInteraction():
	if detectionArea.overlaps_body(player):
		if Input.is_action_just_pressed("interact"):
			if hasAction:
				if canPerformAction:
					canPerformAction = false
					actionPlayer.play("action")
				elif actionIsRepeatable:
					actionPlayer.play("action")
			elif hasInterface:
				if !isInterfaceOpen:
					openInterface()
				else:
					closeInterface()

func setInfo():
	popupLabel.set_visible(false)
	popupLabel.set_text(popup)
	descriptionLabel.set_visible(false)
	if hasAction:
		descriptionLabel.set_text(actionDescription)
	elif hasInterface:
		descriptionLabel.set_text(interfaceDescription)

func showInfo():
	if detectionArea.overlaps_body(player):
		popupLabel.set_visible(true)
	else:
		popupLabel.set_visible(false)

func connectSignals():
	detectionArea.body_exited.connect(_on_player_exit)

func _on_player_exit(body: Node3D) -> void:
	if body.is_in_group("player") && hasResetAnimation:
		actionPlayer.play("reset")
		canPerformAction = true

func openInterface():
	isInterfaceOpen = true
	player.visible = false
	interface.visible = true
	interfaceCamera.make_current()

func closeInterface():
	isInterfaceOpen = false
	player.visible = true
	interface.visible = false
	get_tree().get_first_node_in_group("playerCamera").make_current()
