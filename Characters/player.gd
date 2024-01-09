extends CharacterBody2D

#starting position of the character
@export var startPosition: Vector2= Vector2(0,1)
#Speed
@export var moveSpeed: float = 95

#when script starts, node is accessed
@onready var animationTree = $AnimationTree

#allows the change of state of animation
@onready var state = animationTree.get("parameters/playback")

#controls the pushing of animals out the way

var pushStrength = 1000

func _ready():
	add_to_group("players")
	updateAnimations(startPosition)
	
	
func _physics_process(_delta):
	#variable: gets key input for X,Y direction moving
	var inputDirection = Vector2(
		#the left button with cancel out the right button 
		Input.get_action_strength("right")-Input.get_action_strength("left"),
		#holding up/down at same time will cancel movement out
		Input.get_action_strength("down")-Input.get_action_strength("up")
		
	)
	
	#upon direction input, update animation
	updateAnimations(inputDirection)
	
	#controls how fast the character goes based on button and move speed
	velocity = inputDirection * moveSpeed
	
	states()
	
	#move and slide allows character to move, if collison character can still move slightly
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var pushDirection = collision.get_normal()
			if collision:
				if collision.get_collider().is_in_group("animals"):
					collision.get_collider().newDirection()
					
	
#based on the input, update the animations of the character
func updateAnimations(moveInput : Vector2):
	if(moveInput != Vector2.ZERO):
		animationTree.set("parameters/idle/blend_position",moveInput)
		animationTree.set("parameters/walk/blend_position",moveInput)

#used to control when animations switch state
func  states():
	if(velocity!=Vector2.ZERO):
		state.travel("walk")
	else:
		state.travel("idle")
