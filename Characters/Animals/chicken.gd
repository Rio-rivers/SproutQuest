extends CharacterBody2D


#get sprite status
@onready var sprite = $Sprite2D

#when script starts, node is accessed
@onready var animationTree = $AnimationTree

#allows the change of state of animation
@onready var state = animationTree.get("parameters/playback")
@onready var timer = $Timer

#Speed
@export var moveSpeed: float = 15
#Timer for changing of state
@export var stateTimer : float = randf_range(4, 10)

#enum for different states of animal
enum chickenState {IDLE, EATING,HAPPY, WALK,ASLEEP}

var direction : Vector2 = Vector2.ZERO

#holds the animals current state
var currentState : chickenState = chickenState.IDLE


func _ready():
	add_to_group("chickens")
	add_to_group("animals")
	changeState()

func _physics_process(_delta):
	if(currentState == chickenState.WALK):
		velocity = direction * moveSpeed
		move_and_slide()
		#for each collision check the collision type and if a part of the map change direction
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision:
				if collision.get_collider() is TileMap:
					newDirection()


	
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
	var choice = randi_range(0, 2)
	
	#change to idle
	if(currentState == chickenState.WALK):
		
		state.travel("idle")
		currentState = chickenState.IDLE
		timer.start(stateTimer)
	elif(currentState == chickenState.ASLEEP):
		state.travel("idle")
		currentState = chickenState.IDLE
		timer.start(stateTimer)
	else:
		if (choice == 0):
			state.travel("walking")
			currentState = chickenState.WALK
			newDirection()
		elif (choice == 1):
			state.travel("eating")
			currentState = chickenState.EATING
		elif (choice == 2):
			state.travel("asleep")
			currentState = chickenState.ASLEEP
		timer.start(stateTimer)
		


func _on_timer_timeout():
	changeState()
