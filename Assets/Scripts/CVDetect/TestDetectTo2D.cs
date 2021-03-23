using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TestDetectTo2D : MonoBehaviour
{
    [HimeLib.HelpBox] public string tip = "只要掛上此Comp, 就能自動讀取Manager中的最終偵測點, 並建立Prefab";
    public GameObject Prefab_pointObject;
    public Text debugMsg;
    public bool ShowIcon = true;

    void Update()
    {
        if(debugMsg != null){
            debugMsg.text = "Total Point: " + PositionManager.instance.UnityDetectResult.Count;
        }
        if(ShowIcon){
            foreach (var item in PositionManager.instance.UnityDetectResult)
            {
                GameObject temp = Instantiate(Prefab_pointObject, item, Quaternion.identity);
                Destroy(temp,1);
            }
        }

        if(Input.GetKeyDown(KeyCode.PageUp)){
            ShowIcon = true;
        }
        if(Input.GetKeyDown(KeyCode.PageDown)){
            ShowIcon = false;
        }
    }
}
