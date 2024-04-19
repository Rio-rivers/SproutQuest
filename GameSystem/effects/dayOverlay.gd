extends StaticBody2D

@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("test")
	#animation.play("timeChangeSpring")
	TimeManager.connect("newDay",_on_playDayAnimation)
	


func _on_playDayAnimation():
	animation.play("test")
	#animation.play("timeChangeSpring")
