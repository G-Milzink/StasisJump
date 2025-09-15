@icon("uid://b746ifsjo471f")
extends Area3D
class_name _AreaControl

var firstRun: bool = true

var allPossibleCLearanceCarriers: Array
var allPossibleCodeCarriers: Array
var allAreaPortals: Array

var allObjectsNeedingCodes: Array

func _process(delta: float) -> void:
	if firstRun:
		for area in self.get_overlapping_areas():
			if area.is_in_group("needsClearance"):
				allAreaPortals.append(area)
		for body in self.get_overlapping_bodies():
			if body.is_in_group("canAskForCode"):
				allPossibleCLearanceCarriers.append(body)
		for body in self.get_overlapping_bodies():
			if body.is_in_group("canCarryCode"):
				allPossibleCodeCarriers.append(body)
		handleClearanceDistribution()
		distributeCodes()
		firstRun = false

func handleClearanceDistribution():
	for portal: _Door in allAreaPortals:
		portal.set_clearance_level(GameData.nextClearanceLevel)
		var clearanceCarrier = allPossibleCLearanceCarriers.pick_random()
		allPossibleCLearanceCarriers.erase(clearanceCarrier)
		allObjectsNeedingCodes.append(clearanceCarrier)


func distributeCodes():
	for lockedBody in allObjectsNeedingCodes:
		var codeCarrier = allPossibleCodeCarriers.pick_random()
		allPossibleCodeCarriers.erase(codeCarrier)
		codeCarrier.getCode()
		lockedBody.isLocked = true
		lockedBody.hasClearance = true
		lockedBody.interface.lockScreen.code = codeCarrier.getCode()
