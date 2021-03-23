using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MyUserPool))]
public class MyUserPoolHelper : MonoBehaviour
{
    MyUserPool myUserPool;
    void Start()
    {
        myUserPool = GetComponent<MyUserPool>();

        myUserPool.effectRange = SystemConfig.Instance.GetData<float>("Pool_EffectRange", 10);
        myUserPool.UserAttachPointThreshold = SystemConfig.Instance.GetData<float>("Pool_AttachThreshold", 1.25f);
        myUserPool.countDeadToKill = SystemConfig.Instance.GetData<int>("Pool_CountDead", 10);
        
        ApplicationDelegate.instance.ToDoOnQuit += SavedValues;
    }

    void SavedValues(){
        SystemConfig.Instance.SaveData("Pool_EffectRange", myUserPool.effectRange);
        SystemConfig.Instance.SaveData("Pool_AttachThreshold", myUserPool.UserAttachPointThreshold);
        SystemConfig.Instance.SaveData("Pool_CountDead", myUserPool.countDeadToKill);
    }
}
