using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(PositionManager))]
public class PositionManagerHelper : MonoBehaviour
{
    public Text TXT_ScenceWidth;
    public Text TXT_ScenceHeight;
    public Slider SLD_DetectThreshold;
    public Text TXT_DetectThresholdValue;
    public InputField INP_AllowSizeBase;
    public InputField INP_AllowSizeAdjust;

    public float SceneAdjustSpeed = 1.0f;
    PositionManager positionManager;

    void Awake(){
        positionManager = GetComponent<PositionManager>();
    }

    void Start()
    {
        //Scene W, H
        positionManager.sceneWidth = SystemConfig.Instance.GetData<float>("PM_SceneWidth", 5);
        positionManager.sceneHeight = SystemConfig.Instance.GetData<float>("PM_SceneHeight", 5);
        TXT_ScenceHeight.text = positionManager.sceneHeight.ToString("0.00");
        TXT_ScenceWidth.text = positionManager.sceneWidth.ToString("0.00");

        //Threshold
        SLD_DetectThreshold.SetSavedDataFloat("PM_DetectHeight", 120, x => {
            positionManager.detectThreshold = x;
            TXT_DetectThresholdValue.text = x.ToString("0");
        });

        //AllowSize
        INP_AllowSizeBase.SetSavedDataFloat("PM_SizeBase", 2000, x => {
            positionManager.acceptRect = Mathf.FloorToInt(x);
        });
        INP_AllowSizeAdjust.SetSavedDataFloat("PM_SizeAdjust", 1000, x => {
            positionManager.acceptRectAllowance = Mathf.FloorToInt(x);
        });

    }

    void Update()
    {
        if(Input.GetKey(KeyCode.UpArrow)){
            positionManager.sceneHeight += SceneAdjustSpeed * Time.deltaTime;
            TXT_ScenceHeight.text = positionManager.sceneHeight.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_SceneHeight", positionManager.sceneHeight);
        }
        if(Input.GetKey(KeyCode.DownArrow)){
            positionManager.sceneHeight -= SceneAdjustSpeed * Time.deltaTime;
            TXT_ScenceHeight.text = positionManager.sceneHeight.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_SceneHeight", positionManager.sceneHeight);
        }
        if(Input.GetKey(KeyCode.LeftArrow)){
            positionManager.sceneWidth -= SceneAdjustSpeed * Time.deltaTime;
            TXT_ScenceWidth.text = positionManager.sceneWidth.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_SceneWidth", positionManager.sceneWidth);
        }
        if(Input.GetKey(KeyCode.RightArrow)){
            positionManager.sceneWidth += SceneAdjustSpeed * Time.deltaTime;
            TXT_ScenceWidth.text = positionManager.sceneWidth.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_SceneWidth", positionManager.sceneWidth);
        }
    }
}
