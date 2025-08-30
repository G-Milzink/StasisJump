extends Node3D
class_name base_object

@export_group("Settings:")
@export var popup: String = "an object"
@export var hasAction: bool
@export var hasActionDescription: bool
@export var hasActionAnimation: bool
@export var actionIsReversable: bool
@export var actionIsRepeatable: bool
@export var resetsOnExit: bool
@export var hasInterface: bool
@export_multiline var messages: Array[String] = [
	"ACTION DESCRIPTION HERE", 
	"INTERFACE DESCRIPTION HERE"
	]
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
var actionDescription: String 
var interfaceDescription: String 

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _ready() -> void:
	actionDescription = messages[0]
	interfaceDescription = messages[1]
	applyConfigSettings()
	setInfo()
	connectSignals()

func _process(delta: float) -> void:
	showInfo()
	handleInteraction()

#===============================================================================

func applyConfigSettings():
	popupLabel.set_modulate(ConfigSettings.interfaceTextColor)
	descriptionLabel.set_modulate(ConfigSettings.interfaceTextColor)

func handleInteraction():
	if detectionArea.overlaps_body(player):
		if Input.is_action_just_pressed("interact"):
			if hasAction:
				if canPerformAction:
					canPerformAction = false
					actionPlayer.play("action")
				elif actionIsRepeatable && canPerformAction:
					canPerformAction = false
					actionPlayer.play("action")
				elif actionIsReversable && !canPerformAction:
					canPerformAction = true
					actionPlayer.play("reset")
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

func _on_player_exit(body: Node3D):
	if body.is_in_group("player") && resetsOnExit:
		canPerformAction = true
		actionPlayer.play("reset")

func openInterface():
	PlayerData.hasControl = false
	isInterfaceOpen = true
	player.visible = false
	interface.visible = true
	interfaceCamera.make_current()

func closeInterface():
	isInterfaceOpen = false
	player.visible = true
	interface.visible = false
	get_tree().get_first_node_in_group("playerCamera").make_current()
	PlayerData.hasControl = true
