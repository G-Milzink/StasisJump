extends _UIPanel
class_name _UIPanel_Clearance

@export var accept: Button

var isFirsInteraction: bool = true

func _ready() -> void:
	super()
	accept.button_down.connect(_on_accept)

func _on_accept():
	if isFirsInteraction:
		isFirsInteraction = false
		PlayerData.ClearanceLevel += 1
