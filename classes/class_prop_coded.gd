extends Prop
class_name Prop_Coded

#===============================================================================

@export var canReceiveCode: bool = true
@export_multiline var initialMessage: Array[String] = [
	"Use this to wrap the ",
	"*code*",
	" in a proper sentence"
]
@export_multiline var repeatMessage: Array[String] = [
	"Use this to wrap the ",
	"*code*",
	" in a proper sentence"
]

var hasCode: bool = false
var code: String = ""
var isFirstInteraction: bool = true

#===============================================================================

func  _ready() -> void:
	getCode()
	super()

func setMessage():
	if isFirstInteraction:
		message = initialMessage[0] + code + initialMessage[2]
		isFirstInteraction = false
	else:
		message = repeatMessage[0] + code + repeatMessage[2]

func getCode() -> String:
	canReceiveCode = false
	if !hasCode:
		code = RandomGen.generateCode()
	return code
