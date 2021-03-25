using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionParticleSound : MonoBehaviour
{
    public int affectCount = 4;
    int cur = 0;

    public System.Action OnVirusHit;

    void OnParticleCollision(GameObject other) {
        cur++;
        if(cur > affectCount){
            SoundTest.instance.PlayShot();
            OnVirusHit?.Invoke();
            cur = 0;
            //Debug.Log("Curr");
        }
    }
}
