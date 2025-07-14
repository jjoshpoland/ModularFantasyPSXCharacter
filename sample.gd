@tool
extends Node3D

## Choose a transition name in the Animation Tree Transition node that you want to use
@export var animation_state : String = "idle"
## Set to true to force the character to update. Only needed for this @tool script to prevent the script from running all the time.
@export var need_refresh : bool
## Animation tree controlling your character skeleton
@export var animation_tree : AnimationTree
## Index of the face in the face sprite sheet. This is using the default sprite sheet of 16 faces (0-15 index).
## Changing the sprite sheet for the face will require changing this range max value as well
@export_range(0, 15) var face : int = 0
## The MeshInstance3D for the character Face
@export var face_mesh : MeshInstance3D
## The indices on the Faces sprite sheet that should be used when randomizing a talking appearance. 0-3 by default.
@export var talking_faces : Array[int]

var last_face : int

signal on_blink

func _ready() -> void:
	need_refresh = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if need_refresh && animation_tree != null:
		if animation_tree != null:
			animation_tree.set("parameters/MainAnimation/transition_request", animation_state)
		face_mesh.set_instance_shader_parameter("offset", get_uv_offset_from_face_index(face))
		need_refresh = false
		
## Returns the UV offset of the target face sprite based on the sprite sheet index provided
func get_uv_offset_from_face_index(index : int) -> Vector2:
	var uv_coords : Vector2
	## Assuming a sprite sheet of 4x4, traversing the sprite sheet similar to a 2D array
	## The y axis is counted in rows of 4 by default. 
	## Then we divide by 4 since we are only traversing 1/4th of the sprite sheet to get to the next row
	uv_coords.y = (index / 4) / 4.0
	## The x axis is counted in columns of 4 by default, but only after the row has been selected (so we need the remainder)
	## Then we divide by 4 since we are only traversing 1/4th of the sprite sheet to get to the next column
	uv_coords.x = (index % 4) / 4.0
	return uv_coords

## Called on a timer to update the face to one of the talking face indexes in the talking_faces array
func update_talk_face():
	if talking_faces.size() > 0:
		var rand_talking_face = randi_range(0, talking_faces.size() - 1)
		face_mesh.set_instance_shader_parameter("offset", get_uv_offset_from_face_index(talking_faces[rand_talking_face]))


## Called on a timer to update the face to the blink face, 14 by default. Also adding some randomness to make it not too synchronized/robotic.
func blink():
	# Blinking is face 14 by default, used with the provided sample shader code (faces.gdshader)
	face_mesh.set_instance_shader_parameter("offset", get_uv_offset_from_face_index(14))
	$BlinkTimer.wait_time = 5.0 + randf_range(-1.0, 1.0)
	# Signals another timer to set the face back to normal after a very short blink duration
	on_blink.emit()

func reset_face():
	need_refresh = true
