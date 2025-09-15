extends _Object
class_name _Object_Clearance

var hasClearance: bool = false

func _ready() -> void:
	super()
	add_to_group("canAskForCode")
	interface.mainScreen.accept.button_down.connect(_on_accept)

func _process(delta: float) -> void:
	if hasClearance:
		super(delta)

func _on_accept():
	if !isUsedUp:
		isUsedUp = true
		await get_tree().create_timer(ConfigSettings.panelTextDelay * 3.0).timeout
		interface.close()
