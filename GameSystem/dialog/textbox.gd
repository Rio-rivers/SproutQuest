extends MarginContainer

@onready var label:Label = $MarginContainer/Label
@onready var timer:Timer = $Timer
@onready var animationSprite: AnimatedSprite2D = $AnimatedSprite2D

var displayedText:String = ""
var letterIndex: int = 0
var letterTime:float = 0.02
var pucTime: float = 0.02
var textPause: float = 0.05
var currentAnimation:String = ""
signal dialogDone

func setupText(text:String,beginning):
	displayedText = text
	if beginning:
		animationSprite.play("pipIntro")
		currentAnimation = "pipIntro"
	else:
		displayLetter()
	
	


func displayLetter():
	animationSprite.play("pipTalking")
	label.text += displayedText[letterIndex]
	letterIndex += 1
	if letterIndex >= displayedText.length():
		emit_signal("dialogDone")
		animationSprite.play("pipIdle")
		letterIndex= 0
		displayedText = ""
		return
	timer.start(letterTime)


func _on_timer_timeout():
	displayLetter()




func _on_animated_sprite_2d_animation_finished():
	if currentAnimation == "pipIntro":
		currentAnimation = ""
		displayLetter()

