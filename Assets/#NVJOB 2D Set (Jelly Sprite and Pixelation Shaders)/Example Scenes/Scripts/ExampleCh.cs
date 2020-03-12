using UnityEngine;
using UnityEngine.SceneManagement;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


[ExecuteInEditMode]
public class ExampleCh : MonoBehaviour
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    void OnGUI()
    {
        //--------------

        int screenHeight = Screen.height;
        int screenWidth = Screen.width;

        if (SceneManager.GetActiveScene().name == "Example Jelly Sprite")
        {
            if (GUI.Button(new Rect(10, screenHeight - 40, 135, 30), "Example Pixelation"))
            {
                SceneManager.LoadScene("Example Pixelation", LoadSceneMode.Single);
            }

            GUI.Label(new Rect(screenWidth - 135, screenHeight - 40, 140, 30), "Example Jelly Sprite");
        }
        else
        {
            if (GUI.Button(new Rect(10, screenHeight - 40, 145, 30), "Example Jelly Sprite"))
            {
                SceneManager.LoadScene("Example Jelly Sprite", LoadSceneMode.Single);
            }

            GUI.Label(new Rect(screenWidth - 130, screenHeight - 40, 140, 30), "Example Pixelation");
        }

        //--------------
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
