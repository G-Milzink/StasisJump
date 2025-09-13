@icon("uid://q7q0ygywgcbh")
class_name _Prop
extends StaticBody3D

#===============================================================================

@export var label: String
@export var isInteractive: bool = true
@export var hasUselessMessage: bool
@export var textDisplay: Label3D

var message: String

var isPlayerInReach: bool = false
var isSelected: bool = false
var showingMessage: bool = false

const HIGHLIGHT = preload("res://materials/highlight.tres")

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var meshArray: Array = self.find_children("", "MeshInstance3D", true, false)

#===============================================================================

func _ready() -> void:
	intialSetup()

func _process(delta: float) -> void:
	handleSelection()
	handleInteraction()
	handleTextDisplay()

#===============================================================================

func intialSetup():
	textDisplay.set_modulate(ConfigSettings.interfaceTextColor)
	message = label
	textDisplay.set_text(message)
	textDisplay.set_visible(false)
	if isInteractive:
		self.add_to_group("interactive")


func setMessage():
	if hasUselessMessage: 
		message = StoryData.getUselessMessage()
	else:
		message = label

func handleTextDisplay():
	if !isPlayerInReach:
		message = label
		textDisplay.set_text(message)
		showingMessage = false
	textDisplay.set_visible(isSelected)

func handleInteraction():
	if Input.is_action_just_pressed("interact"):
		if isPlayerInReach && isSelected:
			if !showingMessage:
					showingMessage = true
					setMessage()
					textDisplay.set_text(message)

func handleSelection():
	if meshArray.size() == 0:
		return
	if isSelected:
		for mesh in meshArray:
			mesh.set_material_overlay(HIGHLIGHT)
	else:
		for mesh in meshArray:
			mesh.set_material_overlay(null)
			
#===============================================================================
