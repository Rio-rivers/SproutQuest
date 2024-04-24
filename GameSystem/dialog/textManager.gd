extends Node

@onready var textbox = preload("res://GameSystem/dialog/textbox.tscn")

var dialogs:Array[String]
var lineIndex:int = 0
var nextLine: bool = false
var dialogRunning: bool = false
var currentTextbox
var beginningOfDialog: bool = true

var farmingTutorial:bool = false
var animalTutorial:bool = false

var gameLevel
var parent
func _unhandled_input(event):
	if event.is_action_pressed("nextDialog") and dialogRunning and nextLine:
		if currentTextbox:
			currentTextbox.queue_free()
		lineIndex += 1
		if lineIndex >= dialogs.size():
			dialogRunning = false
			currentTextbox.queue_free()
			currentTextbox = null
			parent.openDialog(dialogRunning)
			lineIndex = 0 
			return
		displayTextbox()

func runDialog(lines):
	if dialogRunning:
		return
	dialogs = lines
	beginningOfDialog = true
	displayTextbox()
	beginningOfDialog = false
	dialogRunning = true

func displayTextbox():
	currentTextbox = textbox.instantiate()
	currentTextbox.connect("dialogDone",endDialog)
	gameLevel = get_node("/root/GameLevel")
	parent = gameLevel.get_node("CanvasLayer/DialogBox")
	parent.openDialog(true)
	parent.add_child(currentTextbox)
	currentTextbox.setupText(dialogs[lineIndex],beginningOfDialog)
	nextLine = false

func endDialog():
	nextLine = true
	
func resetDialog():
	farmingTutorial = false
	animalTutorial = false
	dialogs = []
	currentTextbox = null
	lineIndex= 0
	nextLine= false
	dialogRunning= false
