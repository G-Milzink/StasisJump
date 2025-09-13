extends Node

const multiPageLogFilePath: String = "res://data/MultiPageLogs.json"
const generalMessagesFilePath: String = "res://data/GeneralMessages.json"

var uselessMessages: Array
var outOfReachMsssages: Array
var multiPageLogListArea1: Array
var multiPageLogListArea2: Array
var multiPageLogListArea3: Array
var allMultiPageLogs: Dictionary
var multiPageLogs_Area1: Dictionary
var multiPageLogs_Area2: Dictionary
var multiPageLogs_Area3: Dictionary

func _ready() -> void:
	loadMultiPageLogs()
	loadUselessMessages()
	loadOutOfReachMessages()

#===================================================================================================

func readFromFile(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func loadMultiPageLogs():
	allMultiPageLogs = readFromFile(multiPageLogFilePath)
	multiPageLogs_Area1 = allMultiPageLogs["area1"]
	multiPageLogs_Area2 = allMultiPageLogs["area2"]
	multiPageLogs_Area3 = allMultiPageLogs["area3"]
	multiPageLogListArea1 = multiPageLogs_Area1.keys()
	multiPageLogListArea2 = multiPageLogs_Area2.keys()
	multiPageLogListArea3 = multiPageLogs_Area3.keys()

func loadUselessMessages():
	uselessMessages = readFromFile(generalMessagesFilePath).useless

func loadOutOfReachMessages():
	outOfReachMsssages = readFromFile(generalMessagesFilePath).outOfReach

#===================================================================================================

func getMultiPageLog(area):
	var logs: Dictionary
	var loglist: Array
	match area:
		"area1":
			logs = multiPageLogs_Area1
			loglist = multiPageLogListArea1
		"area2":
			logs = multiPageLogs_Area2
			loglist = multiPageLogListArea2
		"area3":
			logs = multiPageLogs_Area3
			loglist = multiPageLogListArea3
		_:
			print("No logs for this area...")
	
	if loglist.size() >= 1:
		var randomLog = loglist.pick_random()
		var result: Array = logs[randomLog]
		logs.erase(randomLog)
		return result
	else:
		return ["No more story to tell...."]

func getUselessMessage() -> String:
	return uselessMessages.pick_random()

func getOutOfReachMessage():
	return outOfReachMsssages.pick_random()
