extends Control

@onready var borderRect: NinePatchRect = $NinePatchRect


func _ready() -> void:
	applyConfigSettings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func applyConfigSettings():
	borderRect.set_modulate(ConfigSettings.interfaceBorderColor)
