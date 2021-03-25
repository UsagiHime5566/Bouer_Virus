using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using OpenCvSharp;
using OpenCvSharp.CPlusPlus;

[RequireComponent(typeof(PositionManager))]
public class PositionManagerHelper : MonoBehaviour
{
    public Text TXT_ScenceWidth;
    public Text TXT_ScenceHeight;
    public Text TXT_XYBias;
    public Slider SLD_DetectThreshold;
    public Text TXT_DetectThresholdValue;
    public InputField INP_AllowSizeBase;
    public InputField INP_AllowSizeAdjust;
    public RawImage RI_DebugPreview;
    public Toggle TG_ShowDebugImg;

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
        positionManager.X_Shift = SystemConfig.Instance.GetData<float>("PM_XBias", 0);
        positionManager.Y_Shift = SystemConfig.Instance.GetData<float>("PM_YBias", 0);
        TXT_XYBias.text = positionManager.X_Shift.ToString("0.00") + ", " + positionManager.Y_Shift.ToString("0.00");


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

        positionManager.OnResultImgComplete += OnDebugImgComing;
        TG_ShowDebugImg.onValueChanged.AddListener(x => {
            RI_DebugPreview.gameObject.SetActive(x);
        });
    }

    void OnDebugImgComing(Mat mat){
        if(TG_ShowDebugImg.isOn){
            Texture2D tex = new Texture2D(mat.Width, mat.Height, TextureFormat.RGB24, false, false);
            tex.LoadImage(mat.ToBytes(".png"));
            tex.Apply();
            RI_DebugPreview.texture = tex;
        }
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

        //XY Bias
        if(Input.GetKey(KeyCode.O)){
            positionManager.X_Shift -= SceneAdjustSpeed * Time.deltaTime;
            TXT_XYBias.text = positionManager.X_Shift.ToString("0.00") + ", " + positionManager.Y_Shift.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_XBias", positionManager.X_Shift);
        }
        if(Input.GetKey(KeyCode.P)){
            positionManager.X_Shift += SceneAdjustSpeed * Time.deltaTime;
            TXT_XYBias.text = positionManager.X_Shift.ToString("0.00") + ", " + positionManager.Y_Shift.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_XBias", positionManager.X_Shift);
        }
        if(Input.GetKey(KeyCode.K)){
            positionManager.Y_Shift -= SceneAdjustSpeed * Time.deltaTime;
            TXT_XYBias.text = positionManager.X_Shift.ToString("0.00") + ", " + positionManager.Y_Shift.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_YBias", positionManager.Y_Shift);
        }
        if(Input.GetKey(KeyCode.L)){
            positionManager.Y_Shift += SceneAdjustSpeed * Time.deltaTime;
            TXT_XYBias.text = positionManager.X_Shift.ToString("0.00") + ", " + positionManager.Y_Shift.ToString("0.00");
            SystemConfig.Instance.SaveData("PM_YBias", positionManager.Y_Shift);
        }
    }
}
