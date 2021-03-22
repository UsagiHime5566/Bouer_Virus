using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyboardInput : MonoBehaviour
{
    public float moveSpeed = 5;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.W)){
            transform.Translate(0, 0, 1 * Time.deltaTime * moveSpeed);
        }
        if(Input.GetKey(KeyCode.S)){
            transform.Translate(0, 0, -1 * Time.deltaTime * moveSpeed);
        }
        if(Input.GetKey(KeyCode.A)){
            transform.Translate(-1 * Time.deltaTime * moveSpeed, 0, 0);
        }
        if(Input.GetKey(KeyCode.D)){
            transform.Translate(1 * Time.deltaTime * moveSpeed, 0, 0);
        }
    }
}
