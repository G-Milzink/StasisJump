extends Control

@onready var keyGrid: GridContainer = $KeyGrid
@onready var borderRect: NinePatchRect = $NinePatchRect

var numberKeys: Array

func _ready() -> void:
	applyConfigSettings()


func applyConfigSettings():
	borderRect.set_modulate(ConfigSettings.interfaceBorderColor)
	for child in self.find_children("*"):
		if child.is_in_group("numberKeys"):
			child.set_modulate(ConfigSettings.interfaceTextColor)
