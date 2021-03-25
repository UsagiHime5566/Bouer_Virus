using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundTest : HimeLib.SingletonMono<SoundTest>
{
    public bool act;
    public List<AudioSource> audioSource;
    public AudioClip clip;
    public float pinch = 2;
    public float vol = 1;

    void Start(){
        audioSource = new List<AudioSource>(GetComponents<AudioSource>());
        foreach (var item in audioSource)
        {
            item.pitch = pinch;
            item.volume = vol;
            item.clip = clip;
        }
    }
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space)){
            //audioSource.PlayOneShot(audioSource.clip);
        }
    }

    public void PlayShot(){
        if(!act)
            return;
            
        int rand = Random.Range(0, audioSource.Count);
        audioSource[rand].PlayOneShot(audioSource[rand].clip); 
    }
}
