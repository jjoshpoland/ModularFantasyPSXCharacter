using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Faces : MonoBehaviour
{
    /// The gameobject that has the Face
    [SerializeField] public Renderer ModelFace;
    /// The index of the face sprite on the Faces texture you want to display on this character (0-15 with the sample assets)
    [SerializeField] public int CurrentFace = 0;
    /// Is the character currently talking
    [SerializeField] public bool Talking = false;
    /// Which face on your Face texture (sprite sheet) is a blinking face (eyes closed)
    [SerializeField] public int BlinkFace = 14; 
    /// How often the face should change while talking
    [SerializeField] public float FaceChangeRate;
    /// The duration between blinks
    [SerializeField] public float BlinkTime;
    /// How long the eyes are closed during a blink
    [SerializeField] public float BlinkDuration;
    /// An array of indices that indicate which faces should be selected when talking (0-3 by default)
    [SerializeField] public int[] TalkingFaces;

    private float LastFaceChange;
    private float LastBlink;
    private bool Blinking;
    // Start is called before the first frame update
    void Start()
    {
        ResetFace();
    }

    // Update is called once per frame
    void Update()
    {
        if(Talking && Time.time > LastFaceChange + FaceChangeRate)
        {
            UpdateTalkingFace();
            LastFaceChange = Time.time;
        }

        if(Time.time > BlinkTime + LastBlink) 
        {
            Blink();
        }
        // Go back to your chosen face after the blink duration is up
        if(Blinking && Time.time > LastBlink + BlinkDuration)
        {
            ResetFace();
            Blinking = false;
        }
    }

    void UpdateTalkingFace()
    {
        if (TalkingFaces.Length > 0)
        {
            ModelFace.material.SetVector("_Offset", GetUVOffsetFromFaceIndex(Random.Range(0, TalkingFaces.Length)));
        }
    }

    void ResetFace()
    {
        ModelFace.material.SetVector("_Offset", GetUVOffsetFromFaceIndex(CurrentFace));
    }

    Vector2 GetUVOffsetFromFaceIndex(int index) 
    {
        if(index <= -1) 
        {
            return new Vector2();
        }
        Vector2 UVCoords = new Vector2();
        // Assuming a sprite sheet of 4x4, traversing the sprite sheet similar to a 2D array
	    // The y axis is counted in rows of 4 by default. 
	    // Then we divide by 4 since we are only traversing 1/4th of the sprite sheet to get to the next row
        // But then it needs to be negative because Unity
        UVCoords.y = -(index / 4) / 4f;
        // The x axis is counted in columns of 4 by default, but only after the row has been selected (so we need the remainder)
	    // Then we divide by 4 since we are only traversing 1/4th of the sprite sheet to get to the next column
        UVCoords.x = (index % 4) / 4f;
        return UVCoords;
    }

    void Blink()
    {
        ModelFace.material.SetVector("_Offset", GetUVOffsetFromFaceIndex(BlinkFace));
        LastBlink = Time.time;
        Blinking = true;
    }
}
