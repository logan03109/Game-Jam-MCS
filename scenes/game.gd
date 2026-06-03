extends Node2D

func _ready():
	var vp1 = $HSplitContainer/SubViewportContainer/SubViewport
	var vp2 = $HSplitContainer/SubViewportContainer2/SubViewport
	vp2.world_2d = vp1.world_2d
	
	var player2 = $HSplitContainer/SubViewportContainer/SubViewport/player2
	$HSplitContainer/SubViewportContainer/SubViewport.remove_child(player2)
	vp2.add_child(player2)
