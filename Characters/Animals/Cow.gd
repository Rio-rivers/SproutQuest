#this file controls the cows, their movements and their interactions

extends CharacterBody2D
#get sprite status
@onready var sprite = $Body

#when script starts, node is accessed
@onready var animationTree = $AnimationTree

#allows the change of state of animation
@onready var state = animationTree.get("parameters/playback")
@onready var timer = $Timer

#Speed
@export var moveSpeed: float = 10
#Timer for changing of state
@export var stateTimer : float = randf_range(4, 10)

#enum for different states of animal
enum cowState {IDLE, EATING,HAPPY, WALK,ASLEEP, SITTING}

var direction : Vector2 = Vector2.ZERO

#holds the animals current state
var currentState : cowState = cowState.IDLE

var randomChoice = randi_range(0, 1)


func _ready():
	add_to_group("cows")
	add_to_group("animals")
	changeState()

func _physics_process(_delta):
	if(currentState == cowState.WALK):
		velocity = direction * moveSpeed
		move_and_slide()
		#for each collision check the collision type and if a part of the map change direction
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision:
				if collision.get_collider() is TileMap:
					newDirection()
				elif collision.get_collider().is_in_group("animals"):
					if randomChoice == 0:
						newDirection()
					else:
						changeState()
		


func moveFromPlayer(playerPosition: Vector2):
	direction = (playerPosition)

	# Ensure the direction vector is not zero
	if direction == Vector2.ZERO:
		newDirection()
	
	state.travel("walking")
	currentState = cowState.WALK

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
func newDirection():
	direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()
	
	if(direction.x<0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func changeState():
	#allows the animal a random choice in actions
	var choice = randi_range(0, 3)
	
	#change to idle
	if(currentState == cowState.WALK):

		state.travel("idle")
		currentState = cowState.IDLE
		timer.start(stateTimer)
	elif(currentState == cowState.ASLEEP or currentState == cowState.SITTING):
		state.travel("idle")
		currentState = cowState.IDLE
		timer.start(stateTimer)
	else:
		if (choice == 0):
			state.travel("walking")
			currentState = cowState.WALK
			newDirection()
		elif (choice == 1):
			state.travel("eating")
			currentState = cowState.EATING
		elif (choice == 2):
			
			state.travel("asleep")
			currentState = cowState.ASLEEP
		elif (choice == 3):
			
			state.travel("sitting")
			currentState = cowState.SITTING
		timer.start(stateTimer)
		


func _on_timer_timeout():
	changeState()
