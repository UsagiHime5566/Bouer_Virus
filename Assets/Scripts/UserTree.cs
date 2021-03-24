using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;

public class UserTree : MonoBehaviour
{
    public ParticleSystem ParticleTree;
    public Transform Owner;
    void Start()
    {
        var coll = ParticleTree.collision;
        coll.SetPlane(0, TreePool.instance.TreeColliderPlane);
    }

    void Update(){
        if(Owner == null)
            return;

        transform.localPosition = new Vector3(Owner.localPosition.x * TreePool.instance.x_Mapping, Owner.localPosition.z * TreePool.instance.y_Mapping, 0);
    }

    public async void DestroySelf(){
        ParticleTree.Stop();
        await Task.Delay(15000);
        
        if(this == null)
            return;
            
        Destroy(gameObject);
    }
}
