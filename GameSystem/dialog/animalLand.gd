extends Area2D


const animalLines: Array[String]= ["Hei!","This is where you can look after your animals","They need food and water everyday","you can buy a watering can and feed in the market", "once the animals mature they give produce daily","only if you keep them happy and healthy though!"]

func _on_body_entered(body):
	if body is Player:
		if !TextManager.animalTutorial and !TextManager.dialogRunning:
			TextManager.runDialog(animalLines)
			TextManager.animalTutorial = true
