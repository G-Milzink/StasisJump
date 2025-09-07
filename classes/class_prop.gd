class_name Prop
extends Node3D

@export var label: String
@export var hasUselessMessage: bool
@export var messages: Array[String]
@export var detectionArea: Area3D
@export var textDisplay: Label3D

var message: String = ""
var showingMessage: bool = false

#===============================================================================

func _ready() -> void:
	initalSetup()

func _process(delta: float) -> void:
	showText()

#===============================================================================

func initalSetup():
	getMessages()

func getMessages():
	messages = StoryData.getUselessMessages()

func showText():
	pass
	

#===============================================================================
