#this file controls the player, their movements and their interactions

extends CharacterBody2D

class_name Player

#starting position of the character
@export var startPosition: Vector2= Vector2(0,1)
#Speed
@export var moveSpeed: float = 80

#when script starts, node is accessed
@onready var animationTree = $AnimationTree

@onready var animationPlayer = $AnimationPlayer

#allows the change of state of animation
@onready var state = animationTree.get("parameters/playback")

@onready var equippedTool = $EquippedTool.getTool()

#controls the pushing of animals out the way
var pushStrength = 3000

#used to stop movement when a tool is being used
var usingTool = false


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
	
	if not usingTool:
		#controls how fast the character goes based on button and move speed
		velocity = inputDirection * moveSpeed
	else:
		velocity = Vector2.ZERO


	var current_state = state.get_current_node()
	if current_state != "swingAxe" and usingTool:
		usingTool = false
		
		
	states()
	
	
	#move and slide allows character to move, if collison character can still move slightly
	move_and_slide()
	
	
	for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision:
				if collision.get_collider().is_in_group("animals"):
					collision.get_collider().moveFromPlayer(inputDirection.normalized())
					
	




#based on the input, update the animations of the character
func updateAnimations(moveInput : Vector2):
	if(moveInput != Vector2.ZERO):
		if not usingTool:
			animationTree.set("parameters/idle/blend_position",moveInput)
			animationTree.set("parameters/walking/blend_position",moveInput)
			animationTree.set("parameters/swingAxe/blend_position",moveInput)
		
	

#used to control when animations switch state
func  states():
	
	if Input.is_action_just_pressed("useTool"):
		usingTool = true
		
		if equippedTool == "None":
			print("no tool")
		elif equippedTool == "Axe":
			state.travel("swingAxe")
		elif equippedTool == "Test":
			print("working")
			
	elif(velocity!=Vector2.ZERO):
		state.travel("walking")
	else:
		state.travel("idle")
	
