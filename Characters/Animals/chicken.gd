#this file controls the chickens, their movements and their interactions

extends Animal

class_name Chicken

@onready var adultSprite= preload("res://GameSystem/animals/adultChickenSprite.tscn")
@onready var adultAnimation= $AnimationPlayer.get_path()
#get sprite status
@onready var sprite = $childSprite
@onready var childAnimation = $childAnimation
#when script starts, node is accessed
@onready var animationTree = get_node("AnimationTree")

#allows the change of state of animation
@onready var state = animationTree.get("parameters/playback")
@onready var timer = $Timer
@onready var EatingAndDrinkingTimer = $eatingAndDrinkingTimer

@export var FAWTimer : float = randf_range(1, 9)
#Speed
@export var moveSpeed: float = 15
#Timer for changing of state
@export var stateTimer : float = randf_range(4, 10)

var randomChoice = randi_range(0, 2)

#enum for different states of animal
enum chickenState {IDLE, EATING,HAPPY, WALK,ASLEEP}

var direction : Vector2 = Vector2.ZERO

#holds the animals current state
var currentState : chickenState = chickenState.IDLE

var needsAction = true

func _ready():
	TimeManager.connect("newDay",updateAnimal)
	add_to_group("chickens")
	add_to_group("animals")
	changeState()
	EatingAndDrinkingTimer.start(FAWTimer)
	
func save():
	
	var saveDict = {
		"posX": position.x,
		"posY": position.y,
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"age": age,
		"happiness": happiness,
		"fed": fed,
		"watered": watered,
		"isMature": isMature,
	}
	return saveDict

func _physics_process(_delta):
	

	if(currentState == chickenState.WALK):
		velocity = direction * moveSpeed
		move_and_slide()
		#for each collision check the collision type and if a part of the map change direction
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision:
				if collision.get_collider() is TileMap :
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
	currentState = chickenState.WALK

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
	randomChoice = randi_range(0, 2)
	stateTimer = randf_range(4, 10)
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
		if (randomChoice == 0):
			state.travel("walking")
			currentState = chickenState.WALK
			newDirection()
		elif (randomChoice == 1):
			state.travel("eating")
			currentState = chickenState.EATING
		elif (randomChoice == 2):
			state.travel("asleep")
			currentState = chickenState.ASLEEP
		
		timer.start(stateTimer)
		


func _on_timer_timeout():
	changeState()

func updateAnimal():
	FAWTimer = randf_range(1, 9)
	EatingAndDrinkingTimer.start(FAWTimer)
	growAnimal()
	if age == ageOfMaturity:
		updateAnimations()


func updateAnimations():
	
	if age >= ageOfMaturity:
		var newSprite = adultSprite.instantiate()
		add_child(newSprite)
		sprite.call_deferred("queue_free")
		sprite = newSprite

		animationTree.active = false
		animationTree.anim_player = adultAnimation
		animationTree.active = true
		childAnimation.call_deferred("queue_free")
		changeState()
		
func _on_eating_and_drinking_timer_timeout():
	if not watered:
		needsAction = getWater() or needsAction
	if not fed:
		needsAction = getFood() or needsAction
	if needsAction:
		FAWTimer = randf_range(1, 9)
		EatingAndDrinkingTimer.start(FAWTimer)
