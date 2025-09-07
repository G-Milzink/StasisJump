extends Prop
class_name Prop_Flavored


@export_multiline  var flavorText: String
@export var hasRepeatMessage: bool
@export_multiline var repeatMessage: String

var isFirstInteraction: bool = true


func setMessage():
	if isFirstInteraction:
		message = flavorText
		isFirstInteraction = false
	elif hasRepeatMessage:
		message = repeatMessage
	else:
		super()
