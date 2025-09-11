extends _Prop
class_name _Prop_Flavored

#===============================================================================

@export_multiline  var initialMessage: String = "Initial message that only shows once."
@export var hasRepeatMessage: bool
@export_multiline var repeatMessage: String = "This message will repeat."

var isFirstInteraction: bool = true

#===============================================================================

func setMessage():
	if isFirstInteraction:
		message = initialMessage
		isFirstInteraction = false
	elif hasRepeatMessage:
		message = repeatMessage
	else:
		super()
