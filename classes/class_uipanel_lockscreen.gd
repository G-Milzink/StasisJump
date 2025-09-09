extends _UIPanel
class_name _UIPanel_Lockscreen

#===============================================================================

@export var digitsArray: Array[Label]

var currentDigit: int = 0
var numpadIsActive: bool = true
var code: String = "0451"
signal code_entered

@onready var numPad1: Button = $Control/GridContainer/NumPad1
@onready var numPad2: Button = $Control/GridContainer/NumPad2
@onready var numPad3: Button = $Control/GridContainer/NumPad3
@onready var numPad4: Button = $Control/GridContainer/NumPad4
@onready var numPad5: Button = $Control/GridContainer/NumPad5
@onready var numPad6: Button = $Control/GridContainer/NumPad6
@onready var numPad7: Button = $Control/GridContainer/NumPad7
@onready var numPad8: Button = $Control/GridContainer/NumPad8
@onready var numPad9: Button = $Control/GridContainer/NumPad9
@onready var numPad0: Button = $Control/GridContainer/NumPad0

#===============================================================================

func _ready() -> void:
	controlNode.set_modulate(ConfigSettings.interfaceBorderColor)
	numPad1.button_down.connect(_on_numpad_button_down.bind(1))
	numPad2.button_down.connect(_on_numpad_button_down.bind(2))
	numPad3.button_down.connect(_on_numpad_button_down.bind(3))
	numPad4.button_down.connect(_on_numpad_button_down.bind(4))
	numPad5.button_down.connect(_on_numpad_button_down.bind(5))
	numPad6.button_down.connect(_on_numpad_button_down.bind(6))
	numPad7.button_down.connect(_on_numpad_button_down.bind(7))
	numPad8.button_down.connect(_on_numpad_button_down.bind(8))
	numPad9.button_down.connect(_on_numpad_button_down.bind(9))
	numPad0.button_down.connect(_on_numpad_button_down.bind(0))
	resetDigits()

func resetDigits():
	currentDigit = 0
	for i in digitsArray.size():
		digitsArray[i].set_text(".")

func _on_numpad_button_down(value: int):
	if numpadIsActive:
		digitsArray[currentDigit].set_text(str(value))
		currentDigit+=1
		if currentDigit >= digitsArray.size():
			compareInputToCode(code)

func compareInputToCode(code: String):
	var input: String = ""
	for i in digitsArray.size():
		input += digitsArray[i].get_text()
	if input == code:
		emit_signal("code_entered")
	else:
		resetDigits()
