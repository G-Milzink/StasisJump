extends Node3D
class_name base_interface

@export_group("nodes:")
@export var controlNode: Control
@export var borderRect: NinePatchRect

#===============================================================================

func _ready() -> void:
	applyConfigSettings()
	controlNode.visible = false

func _process(delta: float) -> void:
	setVisibility()

#===============================================================================

func applyConfigSettings():
	borderRect.set_modulate(ConfigSettings.interfaceBorderColor)

func setVisibility():
	if self.visibility_changed:
		controlNode.visible = self.visible
