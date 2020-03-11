using System.Collections;
using UnityEngine;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public class Level : MonoBehaviour
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    public Transform fly0;
    public Transform fly1;
    public Transform cam;
    public Transform tunnel;

    //--------------

    float movx, fly0Px, fly1Px;


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    void Start()
    {
        //--------------

        fly0Px = fly0.position.x;
        fly1Px = fly1.position.x;

        //--------------

        StartCoroutine(RandomSpawn());

        //--------------
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    void Update()
    {
        //--------------

        movx += Time.deltaTime * 1.45f;
        cam.position = new Vector3(movx, cam.position.y, cam.position.z);
        tunnel.position = new Vector3(movx, tunnel.position.y, tunnel.position.z);
        fly0.position = new Vector3(fly0Px + movx, fly0.position.y, fly0.position.z);
        fly1.position = new Vector3(fly1Px + movx, fly1.position.y, fly1.position.z);

        //--------------
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    IEnumerator RandomSpawn()
    {
        //--------------        

        yield return new WaitForSeconds(1.0f);

        while (true)
        {
            int randomObj = Random.Range(0, SimplePool.numObjectsList);
            if (SimplePool.GiveObj(randomObj) != null)
            {
                GameObject obj = SimplePool.GiveObj(randomObj);
                Transform trObj = obj.transform;
                trObj.position = new Vector3(movx + 12, trObj.position.y, trObj.position.z);
                obj.SetActive(true);
            }

            yield return new WaitForSeconds(Random.Range(1, 5));
        }

        //--------------
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
