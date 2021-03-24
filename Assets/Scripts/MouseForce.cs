using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseForce : MonoBehaviour
{
    public Camera fromCamera;
    public float nearClip = 10;

    // Update is called once per frame
    void Update()
    {
        Vector2 mousePos = Input.mousePosition;
        transform.position = fromCamera.ScreenToWorldPoint(new Vector3(mousePos.x, mousePos.y, nearClip));
    }
}
