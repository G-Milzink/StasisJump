extends _UIPanel
class_name _UIPanel_Log

var logArray: Array = [""]

@onready var textArea: Label = $Control/TextArea

#===============================================================================

func _ready() -> void:
	controlNode.set_modulate(ConfigSettings.interfaceBorderColor)
	textArea.set_modulate(ConfigSettings.interfaceTextColor)
	logArray = StoryData.getMultiPageLog(storyArea)
	textArea.set_text(str(logArray[0]))
