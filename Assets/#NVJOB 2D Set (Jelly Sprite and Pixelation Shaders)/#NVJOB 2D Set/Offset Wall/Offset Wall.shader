// Copyright (c) 2016 Unity Technologies. MIT license - license_unity.txt
// #NVJOB 2D Set (Jelly Sprite and Pixelation Shaders). MIT license - license_nvjob.txt
// #NVJOB Nicholas Veselov - https://nvjob.github.io
// #NVJOB 2D Set (Jelly Sprite and Pixelation Shaders) V1.2 - https://nvjob.github.io/unity/nvjob-2dset-jelly-sprite
// Patrons - https://nvjob.github.io/patrons


Shader "#NVJOB/2D Set/Offset Wall" {


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Properties{
//----------------------------------------------

[Header(Color Settings)][Space(5)]
_Color("Main Color", Color) = (1,1,1,1)
[NoScaleOffset]_MainTex("Texture", 2D) = "white" {}
_Cutoff("Alpha cutoff", Range(0, 1)) = 0.5
_Emission("Emission", Range(-1, 2)) = 0.5
[Header(Tiling and Offset Settings)][Space(5)]
_TilingX("Tiling X", Float) = 1
_OffsetX("Offset X", Float) = 0
_TilingY("Tiling Y", Float) = 1
_OffsetY("Offset Y", Float) = 0
[Header(Other Settings)][Space(5)]
_Saturation("Saturation", Range(0, 5)) = 1
_Brightness("Brightness", Range(0, 5)) = 1
_Contrast("Contrast", Range(0, 5)) = 1

//----------------------------------------------
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


SubShader{
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

Tags { "RenderType" = "TransparentCutout" "IgnoreProjector" = "True" }
LOD 200
Lighting Off

//----------------------------------------------

CGPROGRAM
#pragma surface surf Standard alphatest:_Cutoff

//----------------------------------------------

sampler2D _MainTex;
fixed4 _Color;
fixed _TilingX, _TilingY, _OffsetX, _OffsetY, _Emission;
fixed _Saturation, _Contrast, _Brightness;

//----------------------------------------------

struct Input {
float3 worldPos;
};

//----------------------------------------------

void surf(Input IN, inout SurfaceOutputStandard o) {
fixed4 tex = tex2D(_MainTex, fixed2((IN.worldPos.x + _OffsetX) * _TilingX, (IN.worldPos.y + _OffsetY) * _TilingY)) * _Color;
float Lum = dot(tex, float3(0.2126, 0.7152, 0.0722));
half3 color = lerp(Lum.xxx, tex, _Saturation);
color = color * _Brightness;
o.Albedo = ((color - 0.5) * _Contrast + 0.5);
o.Alpha = tex.a;
o.Emission = o.Albedo * _Emission;
}

//----------------------------------------------

ENDCG

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

FallBack "Diffuse"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}