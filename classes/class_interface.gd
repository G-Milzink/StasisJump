@icon("uid://c8ulrkgg0rfus")
extends Node3D
class_name _Interface

#===============================================================================

@export var controlNode: Control
@export var animationPlayer: AnimationPlayer
@export var camera: Camera3D
@export var exitButton: Button
@export var lockScreen: _UIPanel
@export var mainScreen: _UIPanel

var isLocked: bool = false
var isOpen: bool = false
signal interface_has_closed

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _ready() -> void:
	exitButton.button_down.connect(_on_buttton_down)
	exitButton.set_modulate(ConfigSettings.interfaceTextColor)
	animationPlayer.animation_finished.connect(_on_animation_finished)
	controlNode.set_visible(self.visible)
	animationPlayer.play("default")

func open():
	if !isOpen:
		animationPlayer.play("activate")
		isOpen = true
		controlNode.set_visible(self.visible)
		camera.set_current(true)

func close():
	if isOpen:
		animationPlayer.play("deactivate")

func _on_buttton_down():
	if isOpen:
		close()

func _on_animation_finished(anim):
	if anim == "activate":
		handleActivation()
	if anim == "deactivate":
		handleDeactivation()

func handleActivation():
	if isLocked:
		lockScreen.set_visible(true)
	else:
		mainScreen.set_visible(true)

func handleDeactivation():
	isOpen = false
	self.set_visible(false)
	controlNode.set_visible(self.visible)
	player.set_visible(true)
	get_tree().get_first_node_in_group("playerCamera").set_current(true)
	PlayerData.hasControl = true
	interface_has_closed.emit()
