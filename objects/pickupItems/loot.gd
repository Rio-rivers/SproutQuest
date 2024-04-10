# this file controls what happens when an item that can be picked up was harvested

extends Area2D

class_name Loot
@export var item : Resource
@onready var collisionShape : CollisionShape2D = $CollisionShape2D

var moving = false
var moveVelocity = Vector2.ZERO
var moveSpeed = 100
var moveDuration = 0.20
var totalDuration = 0.0

func _ready():
	connect("body_entered",_on_area_2d_body_entered)
	
func _process(delta):
	collisionShape.disabled = moving
	if moving:
		position += moveVelocity * delta
		totalDuration += delta
		if totalDuration >= moveDuration:
			moving = false

func bounce():
	var moveDirection= Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0)).normalized()
	moveVelocity = moveDirection * moveSpeed
	moving = true
	
func _on_area_2d_body_entered(body: CharacterBody2D):
	if body is Player:
		body.collectItem(item,1)
		queue_free()
	
#func _on_area_2d_body_entered(body: Node2D):
	#var inventory = body.find_child("Inventory")
	#if inventory:
			#inventory.addItemsToInventory(item,1)
			#queue_free()
