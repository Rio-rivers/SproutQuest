#this file controls the player, their movements and their interactions

extends CharacterBody2D

class_name Player

#starting position of the character
@export var startPosition: Vector2= Vector2(0,1)
#Speed
@export var moveSpeed: float = 80

@export var inventory:InventoryTwo

@export var money:int = 100

#when script starts, node is accessed
@onready var animationTree = $AnimationTree

@onready var animationPlayer = $AnimationPlayer

@onready var playerInventory: InventoryTwo = preload("res://Characters/Player/Inventory/playerInventory.tres")

#allows the change of state of animation
@onready var state = animationTree.get("parameters/playback")

@onready var equippedTool = $EquippedTool.getTool()

#controls the pushing of animals out the way
var pushStrength = 3000

#used to stop movement when a tool is being used
var usingTool = false

# array of animation states. used to stop movement whilst tool/usable item animation is running
var restrictedStates = ["swingHoe","swingAxe","swingPickaxe","pourWateringCan","plantSeed","pourFeed"]

signal moneyChanged

func _ready():
	add_to_group("players")
	updateAnimations(startPosition)
	call_deferred("emit_signal","moneyChanged", money)
	
	
	
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

	# stops player moving whilst tool animation plays
	var current_state = state.get_current_node()
	if current_state not in restrictedStates and usingTool:
		usingTool = false
		
		
	states()
	
	
	#move and slide allows character to move, if collison character can still move slightly
	move_and_slide()
	
	
	for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision:
				if collision.get_collider().is_in_group("animals"):
					collision.get_collider().moveFromPlayer(inputDirection.normalized())
					
	

func save():
	
	var saveDict = {
		"posX": position.x,
		"posY": position.y,
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"money": money,
		#"Inventory": playerInventory.getInventory()
	}
	return saveDict


func collectItem(item: Item, count: int):
	inventory.addItemsToInventory(item, count)

#based on the input, update the animations of the character
func updateAnimations(moveInput : Vector2):
	if(moveInput != Vector2.ZERO):
		if not usingTool:
			animationTree.set("parameters/idle/blend_position",moveInput)
			animationTree.set("parameters/walking/blend_position",moveInput)
			animationTree.set("parameters/swingAxe/blend_position",moveInput)
			animationTree.set("parameters/swingHoe/blend_position",moveInput)
			animationTree.set("parameters/swingPickaxe/blend_position",moveInput)
			animationTree.set("parameters/pourWateringCan/blend_position",moveInput)
			animationTree.set("parameters/plantSeed/blend_position",moveInput)
			animationTree.set("parameters/pourFeed/blend_position",moveInput)

func increaseMoney(amount: int) -> void:
	money += amount
	emit_signal("moneyChanged", money)

func decreaseMoney(amount: int) -> bool:
	if money >= amount:
		money -= amount
		emit_signal("moneyChanged", money)
		return true
	return false
	
func getMoney()->int:
	return money
	
#used to control when animations switch state
func  states():
	#checks for left click
	if Input.is_action_just_pressed("useTool") and equippedTool != "None":#
		usingTool = true
		

		if equippedTool == "Axe":
			state.travel("swingAxe")
		elif equippedTool == "Hoe":
			state.travel("swingHoe")
		elif equippedTool == "Pickaxe":
			state.travel("swingPickaxe")
		elif equippedTool == "Watering Can":
			state.travel("pourWateringCan")
		elif equippedTool.ends_with(" Seed"):
			state.travel("plantSeed")
		elif equippedTool.ends_with("Feed"):
			state.travel("pourFeed")
			
	elif(velocity!=Vector2.ZERO):
		state.travel("walking")
	else:
		state.travel("idle")
	

#used to update equipped item
func _on_equipped_tool_equipped_item(item):
	equippedTool = item
	
