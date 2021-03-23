using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Onoty3D.CharacterParticleAsset.Scripts;


public class MyUserPool : HimeLib.SingletonMono<MyUserPool>
{
    public Button BTN_CreateTextUser;
    public float effectRange = 5;
    public float particleRateNormal = 20;
    public float UserAttachPointThreshold = 0.7f;
    public int countDeadToKill = 10;

    public UserPoint UP_Prefab;
    public CharacterParticle PT_Text_Prefab;
    public List<ParticleSystem> PTCollelct;


    [Header("Test Part")]
    public float randX = 10;
    public float randY = 5;


    int uid = 0;

    void Start()
    {
        BTN_CreateTextUser.onClick.AddListener(CreateUser);

        PTCollelct = new List<ParticleSystem>();
    }


    public void CreateUser(){
        CreateUser(new Vector2(Random.Range(-randX, randX), Random.Range(-randY, randY)));
    }

    public void CreateUser(Vector2 pos){
        var temp = Instantiate(UP_Prefab, new Vector3(pos.x, 0, pos.y), Quaternion.identity, transform);
        temp.name = $"User - {uid}";
        uid++;
    }

    void Update(){
        List<Vector3> dectect = new List<Vector3>(PositionManager.instance.UnityDetectResult);
        foreach (Transform item in transform)
        {
            bool updatePoint = false;
            for (int i = 0; i < dectect.Count; i++)
            {
                float distance = Vector3.Distance(item.position, dectect[i]);
                if(distance < UserAttachPointThreshold){
                    item.position = dectect[i];
                    dectect.RemoveAt(i);
                    i--;
                    updatePoint = true;
                    item.GetComponent<UserPoint>().countDead = 0;
                    break;
                }
            }

            if(!updatePoint){
                item.GetComponent<UserPoint>().countDead++;
            }
        }
        // if point not be used, create user for point
        foreach (var item in dectect)
        {
            CreateUser(new Vector2(item.x, item.z));
        }
    }
}
