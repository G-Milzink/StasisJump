extends Node3D
class_name base_interface

@export_group("nodes:")
@export var controlNode: Control
@export var borderRect: NinePatchRect
@export var codeSource: base_prop
@export var display: Control
@export var input: Control 


var requiresCode: bool
var code: String
var isLocked: bool
var isActive: bool = false

#===============================================================================

func _ready() -> void:
	controlNode.visible = false
	applyConfigSettings()
	handleCodeRetrieval()

func _process(delta: float) -> void:
	handleVisibility()

#===============================================================================

func applyConfigSettings():
	borderRect.set_modulate(ConfigSettings.interfaceBorderColor)

func handleCodeRetrieval():
	requiresCode = get_parent().requiresCode
	if requiresCode:
		codeSource = get_parent().codeSource
		code = retreiveCode()
		isLocked = true
		print_debug(code)

func retreiveCode():
	return codeSource.shareCode()

func handleVisibility():
	if self.visibility_changed:
		isActive = self.visible
		controlNode.visible = self.visible

func handleBeingActive():
	pass
