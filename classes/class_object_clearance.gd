extends _Object
class_name _Object_Clearance


func _ready() -> void:
	super()
	interface.mainScreen.accept.button_down.connect(_on_accept)


func _on_accept():
	if !isUsedUp:
		isUsedUp = true
		await get_tree().create_timer(ConfigSettings.panelTextDelay * 3.0).timeout
		interface.close()
