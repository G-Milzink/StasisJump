extends Node


#region Useless Messages
const uselessMessages: Array[String] = [
	"Nothing of interest here...",
	"This is of no use to me.",
	"I see no way to use this.",
	"I don't know what to do with this.",
	"Useless.",
	".....",
	"This doesn't work.",
	"This won't help me.",
	"I guess not..."
]
func getUselessMessages() -> Array[String]:
	return uselessMessages
#endregion

var multiPageLogList: Array
const multiPageLogs: Dictionary = {
	"log1": ["...1","...2","...3"],
	"log2": ["...2","...3","...4"],
	"log3": ["...3","...4","...5"],
	"log4": ["...4","...5","...6"],
	"log5": ["...5","...6","...7"]
}

func _ready() -> void:
	getMultiPageLogList()

func getMultiPageLogList():
	multiPageLogList = multiPageLogs.keys()

func getMultiPageLog():
	if multiPageLogList.size() >= 1:
		var randomLog = multiPageLogList.pick_random()
		var result: Array = multiPageLogs[randomLog]
		multiPageLogList.erase(randomLog)
		return result
	else:
		return ["No more story to tell...."]
