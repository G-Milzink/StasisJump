@icon("uid://c8ixddrpgpo4w")
extends Control
class_name _UIPanel

@export var controlNode: Control

#===============================================================================

func _ready() -> void:
	initialSetup()

#===============================================================================

func initialSetup():
	controlNode.set_modulate(ConfigSettings.interfaceBorderColor)
