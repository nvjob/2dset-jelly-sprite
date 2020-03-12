// Copyright (c) 2016 Unity Technologies. MIT license - license_unity.txt
// #NVJOB 2D Set (Jelly Sprite and Pixelation Shaders). MIT license - license_nvjob.txt
// #NVJOB Nicholas Veselov - https://nvjob.github.io
// #NVJOB 2D Set (Jelly Sprite and Pixelation Shaders) V1.2 - https://nvjob.github.io/unity/nvjob-2dset-jelly-sprite
// Patrons - https://nvjob.github.io/patrons


Shader "#NVJOB/2D Set/Pixelation" {


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Properties{
//----------------------------------------------

[Header(Color Settings)][Space(5)]
_Color("Tint", Color) = (1,1,1,1)
[Header(Pixelation)][Space(5)]
_CellX("Cell Size X", float) = 1
_CellY("Cell Size Y", float) = 1
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

Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" "PreviewType" = "Plane" "CanUseSpriteAtlas" = "True" }
GrabPass { "_PixelationGrab"}

Cull Off
Lighting Off
ZWrite Off

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

Pass{
//----------------------------------------------

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

//----------------------------------------------

sampler2D _PixelationGrab;
fixed4 _Color;
fixed _Saturation, _Contrast, _Brightness, _CellX, _CellY;

//----------------------------------------------

struct appdata_t {
float4 vertex : POSITION;
float4 color : COLOR;
float2 texcoord : TEXCOORD0;
};

//----------------------------------------------

struct v2f {
float4 vertex : SV_POSITION;
float4 color : COLOR;
float4 texcoord : TEXCOORD0;
};

//----------------------------------------------

v2f vert(appdata_t IN) {
v2f OUT;
OUT.vertex = UnityObjectToClipPos(IN.vertex);
OUT.color = IN.color * _Color;
OUT.texcoord = ComputeGrabScreenPos(OUT.vertex);
return OUT;
}

//----------------------------------------------

float4 frag(v2f IN) : COLOR {
float2 splitting = IN.texcoord.xy / IN.texcoord.w;
half2 cellXY = half2(_CellX * 0.005, _CellY * 0.005);
splitting = round(splitting / cellXY);
splitting *= cellXY;
float4 tex = tex2D(_PixelationGrab, splitting);
fixed Lum = dot(tex, float3(0.2126, 0.7152, 0.0722));
fixed3 color = lerp(Lum.xxx, tex, _Saturation);
color = color * _Brightness;
color = (color - 0.5) * _Contrast + 0.5;
return float4(color, 1) * IN.color;
}

//----------------------------------------------

ENDCG
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}