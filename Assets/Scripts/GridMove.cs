using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class GridMove : MonoBehaviour
{
    public float repeatY = 1;
    public float speed = 1;
    public Material gridMaterial;
    public float colorDuration = 5;
    void Start()
    {
        transform.DOMoveY(-repeatY, speed).SetLoops(-1, LoopType.Restart).SetEase(Ease.Linear);
        gridMaterial.DOFade(0, colorDuration).SetLoops(-1, LoopType.Yoyo).SetEase(Ease.InQuad);
    }

    void OnApplicationQuit() {
        gridMaterial.color = new Color32(0, 165, 0, 165);
    }
}
