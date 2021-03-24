using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TreePool : HimeLib.SingletonMono<TreePool>
{
    public UserTree Prefab_Tree;
    public Transform TreeColliderPlane;
    public float x_Mapping = 1;
    public float y_Mapping = 1;

    int treeIndex = 0;

    public UserTree CreateNewUserTree(float x, float y){
        var temp = Instantiate(Prefab_Tree, transform);
        temp.transform.localPosition = new Vector3(x, y, 0);
        temp.name = $"Tree - {treeIndex}";
        treeIndex++;
        return temp;
    }

    void Start()
    {
        
    }
}
