using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Onoty3D.CharacterParticleAsset.Scripts;
using DG.Tweening;

public class UserPoint : MonoBehaviour
{
    public Transform moonCircle;
    public GameObject bubbleEffect;
    public Dictionary<Transform, CharacterParticle> particles;
    public int countDead = 0;
    public float rotateTime = 2.5f;

    void Awake()
    {
        particles = new Dictionary<Transform, CharacterParticle>();
    }

    void Start(){
        StartCoroutine(CheckTextAlive());
        moonCircle.DORotate(new Vector3(0, 360, 0), rotateTime, RotateMode.FastBeyond360).SetLoops(-1, LoopType.Restart);
    }

    void Update()
    {
        CheckUserInRange();
        if(countDead >= MyUserPool.instance.countDeadToKill){

            bubbleEffect.transform.parent = null;
            var emt = bubbleEffect.GetComponent<ParticleSystem>().emission;
            emt.enabled = false;
            Destroy(bubbleEffect, 3);
            Destroy(gameObject);
        }
            
    }

    public void DeleteTextWithKey(Transform key){
        if(particles == null)
            return;

        if(particles.ContainsKey(key)){
            Destroy(particles[key].gameObject);
            particles.Remove(key);
        }
    }

    WaitForSeconds wait = new WaitForSeconds(0.5f);
    IEnumerator CheckTextAlive(){
        while(true){
            foreach (var txt in particles)
            {
                if(txt.Key == null){
                    var emit = txt.Value.GetComponent<ParticleSystem>().emission;
                    emit.enabled = false;
                }
            }
            yield return wait;
        }
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
