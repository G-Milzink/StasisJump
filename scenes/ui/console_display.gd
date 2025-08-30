extends Control

@onready var borderRect: NinePatchRect = $NinePatchRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	applyConfigSettings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func applyConfigSettings():
	borderRect.set_modulate(ConfigSettings.interfaceBorderColor)
