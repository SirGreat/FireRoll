extends CanvasLayer

func _ready():
	#var player = get_parent().get_parent().get_node("Outdoor Map/Bushes/Player")
	#$"Center Bot/Player Stats/Gold/HBoxContainer/Label".text = str(player.gold)
	pass

func _on_Player_Health_Changed(value):
	$"Center Bot/Player Stats/Health Bar/Health Progress Bar".set_value(value)
	

func _on_Player_Stamina_Changed(value):
	$"Center Bot/Player Stats/Stamina Bar/Stamina Progress Bar".set_value(value)


func _on_Player_Gold_Changed(Gold):
	$"Center Bot/Player Stats/Gold/HBoxContainer/Label".text = str(Gold)



func _on_ShopButton_pressed():
	var mainScene = get_parent().get_parent()
	updateShopInfo()
	get_tree().paused = true
	mainScene.get_node("PAGES/Shop HUD").layer = 2

func updateShopInfo():
	# Grab current weapon stuff
	var mainScene = get_parent().get_parent()
	var currentWeapon = mainScene.get_node("Outdoor Map/Bushes/Player/Base/Weapon").get_child(0)
	var shopHUDNode = mainScene.get_node("PAGES/Shop HUD/MarginContainer/VBoxContainer/HBoxContainer")
	# Update Weapon Name
	shopHUDNode.get_node("Weapons Container/Sub Container/Name").text = currentWeapon.Name
	
	# Update Weapon Level
	shopHUDNode.get_node("Weapons Container/Sub Container/Level").text = "Level " + str(currentWeapon.Level)
	
	# Update Weapon Description
	shopHUDNode.get_node("Weapons Container/Description").text = currentWeapon.Description
	
	# Update Weapon Attributes
	# Damage
	shopHUDNode.get_node("Attributes Container/Damage/Damage Stat").text = str(currentWeapon.Damage)
	# Attack Speed
	# Critical Chance
	shopHUDNode.get_node("Attributes Container/Crit Chance/Stat").text = str(currentWeapon.CriticalChance)
	# Critical Multiplier
	shopHUDNode.get_node("Attributes Container/Crit Mult/Stat").text = str(currentWeapon.CriticalMultiplier)
	# Knockback
	shopHUDNode.get_node("Attributes Container/Knockback/Stat").text = str(currentWeapon.Knockback)