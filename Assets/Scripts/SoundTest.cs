using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundTest : HimeLib.SingletonMono<SoundTest>
{
    public List<AudioSource> audioSource;
    public float pinch = 2;
    public float vol = 1;

    void Start(){
        audioSource = new List<AudioSource>(GetComponents<AudioSource>());
        foreach (var item in audioSource)
        {
            item.pitch = pinch;
            item.volume = vol;
        }
    }
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space)){
            //audioSource.PlayOneShot(audioSource.clip);
        }
    }

    public void PlayShot(){
        int rand = Random.Range(0, audioSource.Count);
        audioSource[rand].PlayOneShot(audioSource[rand].clip); 
    }
}
