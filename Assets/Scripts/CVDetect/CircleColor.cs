using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
public class CircleColor : MonoBehaviour
{
    Color[] randColors = new Color[5];
    SpriteRenderer spr;
    float colorAlpha = 0.5f;
    float switchTime = 0.05f;
    float curTime = 0;
    int colorIndex = 0;
    void Start()
    {
        randColors[0] = GetAlphaColor(Color.red, colorAlpha);
        randColors[1] = GetAlphaColor(Color.yellow, colorAlpha);
        randColors[2] = GetAlphaColor(Color.green, colorAlpha);
        randColors[3] = GetAlphaColor(Color.cyan, colorAlpha);
        randColors[4] = GetAlphaColor(Color.blue, colorAlpha);

        spr = GetComponent<SpriteRenderer>();
    }

    void Update()
    {
        curTime += Time.deltaTime;
        if(curTime < switchTime)
            return;

        curTime = 0;
        spr.color = randColors[colorIndex];
        colorIndex = (colorIndex + 1) % randColors.Length;
    }

    Color GetAlphaColor(Color color, float alpha){
        return new Color(color.r, color.g, color.b, alpha);
    }
}
