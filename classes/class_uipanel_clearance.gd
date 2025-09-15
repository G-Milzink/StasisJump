extends _UIPanel
class_name _UIPanel_Clearance

@export_multiline var messages: Array[String]
@export var accept: Button

var isFirsInteraction: bool = true

@onready var textDisplay: Label = $Control/TextArea


func _ready() -> void:
	super()
	controlNode.set_modulate(ConfigSettings.interfaceTextColor)
	textDisplay.set_text(messages[0])
	accept.button_down.connect(_on_accept)


func _on_accept():
	if isFirsInteraction:
		isFirsInteraction = false
		PlayerData.ClearanceLevel += 1
		await get_tree().create_timer(ConfigSettings.panelTextDelay).timeout
		textDisplay.set_text(messages[1])
		await get_tree().create_timer(ConfigSettings.panelTextDelay * 2.0).timeout

#===============================================================================
