using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Onoty3D.CharacterParticleAsset.Scripts;

public class UserPoint : MonoBehaviour
{
    public Dictionary<Transform, CharacterParticle> particles;
    void Start()
    {
        particles = new Dictionary<Transform, CharacterParticle>();
    }

    // Update is called once per frame
    void Update()
    {
        CheckUserInRange();
    }


    void CheckUserInRange(){
        foreach (Transform item in MyUserPool.instance.transform)
        {
            if(item == transform)
                continue;
            float distance = Vector3.Distance(item.position, transform.position);

            if(distance < MyUserPool.instance.effectRange){
                if(!particles.ContainsKey(item)){
                    var temp = Instantiate(MyUserPool.instance.PT_Text_Prefab, transform.position, Quaternion.identity, transform);
                    particles[item] = temp;
                }
                //particles[item].GetComponent<ParticleSystem>().Play();
                particles[item].transform.LookAt(item);
                string nextText = (distance * 100).ToString("0");
                if(particles[item].Text != nextText)
                    particles[item].Text = nextText;
                
                var shape = particles[item].GetComponent<ParticleSystem>().shape;
                shape.position = new Vector3(0, 0, distance/2);
                shape.scale = new Vector3(distance/2, 1, 1);

                var emit = particles[item].GetComponent<ParticleSystem>().emission;
                emit.enabled = true;

            } else {
                if(particles.ContainsKey(item)){
                    //particles[item].GetComponent<ParticleSystem>().Stop();
                    particles[item].transform.LookAt(item);

                    var emit = particles[item].GetComponent<ParticleSystem>().emission;
                    emit.enabled = false;
                }
            }
        }
    }
}
