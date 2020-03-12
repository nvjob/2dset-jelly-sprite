// Copyright (c) 2016 Unity Technologies. MIT license - license_unity.txt
// #NVJOB Simple Pool. MIT license - license_nvjob.txt
// #NVJOB Nicholas Veselov - https://nvjob.github.io
// #NVJOB Simple Pool v1.2 - https://nvjob.github.io/unity/nvjob-simple-pool


using UnityEngine;
using System.Collections.Generic;

[HelpURL("https://nvjob.github.io/unity/nvjob-simple-pool")]
[AddComponentMenu("#NVJOB/Simple Pool")]


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


public class SimplePool : MonoBehaviour
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    [Header("Objects List")]
    public List<ObjectsPool> ObjectsList = new List<ObjectsPool>();

    [Header("Information")] // These variables are only information.
    public string HelpURL = "nvjob.github.io/unity/nvjob-simple-pool";
    public string ReportAProblem = "nvjob.github.io/reportaproblem";
    public string Patrons = "nvjob.github.io/patrons";

    //--------------

    static Transform thisTransform;
    static int[] numberObjects;
    static GameObject[][] stObjects;
    static public int numObjectsList;


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    private void Awake()
    {
        //--------------

        thisTransform = transform;
        numObjectsList = ObjectsList.Count;
        AddObjectsToPool();

        //--------------
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    private void AddObjectsToPool()
    {
        //--------------

        numberObjects = new int[numObjectsList];
        stObjects = new GameObject[numObjectsList][];

        //--------------

        for (int num = 0; num < numObjectsList; num++)
        {
            numberObjects[num] = ObjectsList[num].numberObjects;
            stObjects[num] = new GameObject[numberObjects[num]];
            InstanInPool(ObjectsList[num].obj, stObjects[num]);
        }

        //--------------
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    static private void InstanInPool(GameObject obj, GameObject[] objs)
    {
        //--------------

        for (int i = 0; i < objs.Length; i++)
        {
            objs[i] = Instantiate(obj);
            objs[i].SetActive(false);
            objs[i].transform.parent = thisTransform;
        }

        //--------------
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    static public GameObject GiveObj(int num)
    {
        //--------------

        for (int i = 0; i < numberObjects[num]; i++) if (!stObjects[num][i].activeSelf) return stObjects[num][i];
        return null;

        //--------------
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    static public void Takeobj(GameObject obj)
    {
        //--------------

        obj.SetActive(false);
        if (obj.transform.parent != thisTransform) obj.transform.parent = thisTransform;

        //--------------
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


[System.Serializable]

public class ObjectsPool
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    public GameObject obj;
    public int numberObjects = 100;
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}