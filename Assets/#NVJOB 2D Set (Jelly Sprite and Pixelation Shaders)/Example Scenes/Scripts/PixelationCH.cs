using UnityEngine;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


[ExecuteInEditMode]
public class PixelationCH : MonoBehaviour
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    public GameObject[] example;
    public Material customPixel;

    //--------------

    float chPixel;


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    void Awake()
    {
        //--------------

        chPixel = 1.0f;
        customPixel.SetFloat("_CellX", chPixel);
        customPixel.SetFloat("_CellY", chPixel);

        //--------------
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    void OnGUI()
    {
        //--------------

        if (GUI.Button(new Rect(10, 10, 80, 30), "Pixelation"))
        {
            for (int i = 0; i < example.Length; i++) example[i].SetActive(false);
            example[0].SetActive(true);
        }

        //--------------

        if (GUI.Button(new Rect(100, 10, 180, 30), "Pixelation Black and White"))
        {
            for (int i = 0; i < example.Length; i++) example[i].SetActive(false);
            example[1].SetActive(true);
        }

        //--------------


        if (GUI.Button(new Rect(290, 10, 160, 30), "Pixelation High Contrast"))
        {
            for (int i = 0; i < example.Length; i++) example[i].SetActive(false);
            example[2].SetActive(true);
        }

        //--------------

        if (GUI.Button(new Rect(460, 10, 115, 30), "Pixelation Sepia"))
        {
            for (int i = 0; i < example.Length; i++) example[i].SetActive(false);
            example[3].SetActive(true);
        }

        //--------------

        if (GUI.Button(new Rect(585, 10, 70, 30), "Custom"))
        {
            for (int i = 0; i < example.Length; i++) example[i].SetActive(false);
            example[4].SetActive(true);
            chPixel = 1.0f;
            customPixel.SetFloat("_CellX", chPixel);
            customPixel.SetFloat("_CellY", chPixel);
        }

        if (example[4].activeSelf)
        {
            if (GUI.Button(new Rect(585, 45, 25, 20), "-"))
            {
                chPixel += 0.1f;
                customPixel.SetFloat("_CellX", chPixel);
                customPixel.SetFloat("_CellY", chPixel);
            }
            if (GUI.Button(new Rect(630, 45, 25, 20), "+"))
            {
                chPixel -= 0.1f;
                customPixel.SetFloat("_CellX", chPixel);
                customPixel.SetFloat("_CellY", chPixel);
            }
        }

        //--------------

        if (GUI.Button(new Rect(665, 10, 40, 30), "Off"))
        {
            for (int i = 0; i < example.Length; i++) example[i].SetActive(false);
        }

        //--------------
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
