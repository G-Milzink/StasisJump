@icon("uid://q7q0ygywgcbh")
class_name Prop
extends Node3D

#===============================================================================

@export var label: String
@export var hasUselessMessage: bool
@export var detectionArea: Area3D
@export var textDisplay: Label3D

var messages: Array[String]
var message: String = ""
var playerInRange: bool = false
var showingMessage: bool = false

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

#===============================================================================

func _ready() -> void:
	getMessages()
	intialSetup()
	conectSignals()
	

func _process(delta: float) -> void:
	handleInteraction()
	handleTextDisplay()

#===============================================================================

func intialSetup():
	textDisplay.set_modulate(ConfigSettings.interfaceTextColor)
	message = label
	textDisplay.set_text(message)
	textDisplay.set_visible(false)

func conectSignals():
	detectionArea.body_entered.connect(_on_body_entered)
	detectionArea.body_exited.connect(_on_body_exit)

func _on_body_entered(body):
	if body == player:
		playerInRange = true

func _on_body_exit(body):
	if body == player:
		playerInRange = false
		showingMessage = false
		message = label
		textDisplay.set_text(message)

func getMessages():
	if hasUselessMessage:
		messages = StoryData.getUselessMessages()

func setMessage():
	if hasUselessMessage: 
		message = messages[randi_range(0, messages.size()-1)]
	else:
		message = label

func handleTextDisplay():
	textDisplay.set_visible(playerInRange)

func handleInteraction():
	if playerInRange:
		if !showingMessage:
			if Input.is_action_just_pressed("interact"):
				showingMessage = true
				setMessage()
				textDisplay.set_text(message)

#===============================================================================
