using UnityEngine;
using System.Collections;
using UnityEngine.UI;

[RequireComponent(typeof(RawImage))]
public class InfraredSourceView : MonoBehaviour 
{
    RawImage targetImage;
    void Start () 
    {
        targetImage = GetComponent<RawImage>();
    }
    
    void Update()
    {
        if (InfraredSourceManager.instance == null)
        {
            return;
        }

        targetImage.texture = InfraredSourceManager.instance.GetInfraredTexture();
    }
}
