# Modular Fantasy PSX Character
## What is in this repo?
This repository contains documentation and sample code for the Modular Fantasy PSX Character. This documentation is currently focused on Godot, but all the guidance will apply in Unity as well. A custom Unity package for these assets is coming in the future.
![Godot_v4 4 1-stable_win64_vVEVchGVe4](https://github.com/user-attachments/assets/2da89acc-7d8c-4463-aae9-67e3a53bd124)

The sample.gd script contains some example functions you can use to manipulate the model in Godot. 
The faces.cs script contains the same content, but made for Unity.
These are mostly for using the facial features.

There is a gdshader file for the face shader for Godot and a faces.shadergraph file for the face shader in Unity.
All Unity specific content is included in the package for sale on the Unity Asset Store.

## What is a Modular Character?
A modular character is a 3d model where you can swap out the pieces at runtime. This is perfect for making any game where the character needs to change their clothes, like Elder Scrolls, Red Dead Redemption, or Breath of the Wild. 

This model uses a different material for every type of surface. This means that if you want to change the color or the texture of a specific piece, you are welcome to do that.

Even the faces are modular - you can change the facial expression, add new facial expressions, or draw entire new faces as you desire.

This model has been pre-rigged with the [ExplosiveLLC](https://www.explosive.ws/products/rpg-animation-fbx-for-godot-blender) skeleton. KayPee has made a fantastic set of animations that can be pulled directly into Godot as animation libraries or directly into Unity's Mecanim animations and used with this model out of the box. The preview scene uses animations from the RPG character pack.

## What is PSX?
PSX is a term referring to original Sony Playstation graphics and is widely used to describe game graphics from the late 90s and early 2000s.

This style uses:
- Simple models (very low-poly)
- Low-res textures
- Simple rigging (4 or fewer bones per mesh part)

This style is popular with game developers because it is easy to edit and to add a lot of character with simple pieces. This is distinct from modern stylized "low-poly" which uses a lot of polygons with hard edges to show very elegant sculpting techniques. I wanted to make this character in this style because it is so much easier to maintain and to copy this style than the popular "low-poly" style.

## How do I use this character asset?
Import the .glb or .fbx file into your game engine of choice and it should be recognized as a humanoid skeleton and be ready to go. 
#### To make the animations work in Godot, you may need to follow a process specific to the animation pack.
Godot's animation remapping workflow is still difficult to use.
See this repo for how to set up Explosive LLC animations with this model. https://github.com/scotmcp/explosive.ws-to-godot
You will need to use the bonemap in Scot's repo for the skeleton on this character to make it work with the animation import process used in Scot's repo. (Thank you to Scot for setting that up)
![Godot_v4 4 1-stable_win64_UQKwQ5oNj5](https://github.com/user-attachments/assets/84eaa6a4-21c2-4c65-8af2-5932eb9b71fa)

### Why does the character look broken when I import it?
When you first import the model, all of the model parts are enabled at once. So the character is wearing every hat, every armor, and every shoe at the same time. You will need to go in and hide the meshes you don't want and show the meshes you do want. In the example below, you will see that I have shown a lot of plate armor pieces for the human knight, but no orc body parts.

![Godot_v4 4 1-stable_win64_XFK0UPTzDE](https://github.com/user-attachments/assets/1e41d85b-9f81-4f45-838f-c098f754b16a)

This process is this same in Unity, just disable the GameObjects for each mesh you don't want to see.
### Can I just delete the meshes I don't want?
Yes, but you don't need to. They hardly take up any memory because they are so simple and they do not occupy any video memory if they are hidden. And putting them back in (at runtime especially) is a complex operation that I have not tested.

### How do I change the color of one of the parts?
First, I recommend creating a Standard Material for each material slot on the model. You can still use the textures I provide, but it will be much easier to manage the materials once they are in the game engine resource folders. 

In Godot, simply add a new material as the Surface Material Override for that mesh. You can also change the color of the mesh once you have specified your own material.

In Unity, simply swap out the material with a Unity engine material.

Keep in mind that if you change the color or texture on the material, it will change for all meshes that use that material. So if you want one model to have gold plate armor and another to have rusty plate armor, you need to either use different materials or manage them in code. 
To manage them in code, different engines handle this differently:
- For Godot: https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/shading_language.html#per-instance-uniforms
- For Unity: Built-In Renderer: https://docs.unity3d.com/6000.0/Documentation/ScriptReference/MaterialPropertyBlock.html, URP: Just make a new material and add it. The batcher is fast.

The number of materials you use is not that important in Godot, but is extremely important in Unity due to draw calls.
### How do I change the faces?
For using the different facial expressions, check out the sample.gd script for various functions for using a different face. There is blinking and talking by default but you can also just pick any face by an index value.

The faces are textures that are on a sprite sheet. It is a 128x128 sprite sheet and each face is a 32x32 sprite. So there are 16 total faces by default. You can make a bigger sprite sheet if you want to add more faces or replace the sprite sheet with faces of your own. You will need to recalculate how to look at the rows and columns of faces on the sprite sheet if you change the size or quantity.
![Aseprite_mqLZEAaZlw](https://github.com/user-attachments/assets/a1c59de9-b197-4a1b-a0b4-f1c561639724)

### Jiggle Bones

![Godot_v4 4 1-stable_win64_hfvwaEQQjN](https://github.com/user-attachments/assets/5990f1cf-5e27-451f-b23e-b1a26a1675cd)

I have set up bones for the accessory attachments that can be configured for physics forces if desired (e.g. SpringBoneSimulator3D in Godot). The bones are:
- Root: Tail, End: Tail.001
- Root: HipHolster_L, End: HipHolster_L.001
- Root: HipHolster_R, End: HipHolster_R.001
- Root: HeadAccessory, End: HeadAccessory.001

### How can I add on to this character?
You can import the file into blender and do your best.\
OR,\
You can send me an email at heavyhandgames@gmail.com and I'll be making periodic updates and potentially expansion packs based on user suggestions.

### Can I get a female version of this character?
I will be releasing a female version of this pack. It requires reworking a lot of the models, weight painting, and all the testing that goes with that, so it will be a separate asset pack that still uses all the same code and features listed in this repo.

### I have an issue/found a defect.
Open an issue on this repo and I will analyze and address based on that.
