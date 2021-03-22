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

    public UserPoint UP_Prefab;
    public CharacterParticle PT_Text_Prefab;
    public List<ParticleSystem> PTCollelct;


    [Header("Test Part")]
    public float randX = 10;
    public float randY = 5;
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
    }

    // Update is called once per frame
    void Update()
    {
        foreach (Transform item in transform)
        {
            
        }
    }
}
