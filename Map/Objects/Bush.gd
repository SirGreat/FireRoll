extends Sprite

func _ready():
	$Effect.visible = false


func _on_Area2D_body_entered(body):
	#print ("SPRINKLE LEAVES")
	$AnimationPlayer.play("Leaves Effect")
