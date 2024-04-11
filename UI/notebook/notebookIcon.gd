extends Panel

var isOpened: bool = false

signal toggleNotebook(value)
signal close
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if isOpened:
		emit_signal("toggleNotebook",0)
		isOpened = false
	else:
		emit_signal("toggleNotebook",1)
		isOpened = true
