using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllowMultiDisplay : MonoBehaviour
{
    void Start()
    {
        ActiveMultiScreen();
    }

    void ActiveMultiScreen(){
        Debug.Log("displays connected: " + Display.displays.Length);
        for (int i = 0; i < Display.displays.Length; i++)
        {
            Display.displays[i].Activate();
        }
    }
}
