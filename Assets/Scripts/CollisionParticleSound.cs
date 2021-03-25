using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionParticleSound : MonoBehaviour
{
    public int affectCount = 4;
    int cur = 0;

    void OnParticleCollision(GameObject other) {
        cur++;
        if(cur > affectCount){
            SoundTest.instance.PlayShot();
            cur = 0;
            Debug.Log("Curr");
        }
    }
}
