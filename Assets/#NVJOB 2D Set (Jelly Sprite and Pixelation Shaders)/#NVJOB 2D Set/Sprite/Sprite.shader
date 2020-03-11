// Copyright (c) 2016 Unity Technologies. MIT license - license_unity.txt
// #NVJOB 2D Set (Jelly Sprite and Pixelation Shaders). MIT license - license_nvjob.txt
// #NVJOB Nicholas Veselov - https://nvjob.github.io
// #NVJOB 2D Set (Jelly Sprite and Pixelation Shaders) V1.2 - https://nvjob.github.io/unity/nvjob-2dset-jelly-sprite
// Patrons - https://nvjob.github.io/patrons


Shader "#NVJOB/2D Set/Sprite" {


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Properties{
//----------------------------------------------

[Header(Color Settings)][Space(5)]
_Color("Tint", Color) = (1,1,1,1)
[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
[MaterialToggle] PixelSnap("Pixel snap", Float) = 0
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

//----------------------------------------------

Cull Off
Lighting Off
ZWrite Off
Blend One OneMinusSrcAlpha

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

Pass{
//----------------------------------------------

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile _ PIXELSNAP_ON
#include "UnityCG.cginc"

//----------------------------------------------

struct appdata_t{
float4 vertex : POSITION;
float4 color : COLOR;
float2 texcoord : TEXCOORD0;
};

//----------------------------------------------

struct v2f{
float4 vertex : SV_POSITION;
fixed4 color : COLOR;
float2 texcoord : TEXCOORD0;
};

//----------------------------------------------

sampler2D _MainTex;
sampler2D _AlphaTex;
float _AlphaSplitEnabled;
fixed4 _Color;
fixed _Saturation, _Contrast, _Brightness;

//----------------------------------------------

v2f vert(appdata_t IN){
v2f OUT;
OUT.vertex = UnityObjectToClipPos(IN.vertex);
OUT.texcoord = IN.texcoord;
OUT.color = IN.color * _Color;
#ifdef PIXELSNAP_ON
OUT.vertex = UnityPixelSnap(OUT.vertex);
#endif
return OUT;
}

//----------------------------------------------

fixed4 SampleSpriteTexture(float2 uv){
fixed4 color = tex2D(_MainTex, uv);
#if UNITY_TEXTURE_ALPHASPLIT_ALLOWED
if (_AlphaSplitEnabled)
color.a = tex2D(_AlphaTex, uv).r;
#endif
return color;
}

//----------------------------------------------

fixed4 frag(v2f IN) : SV_Target{
fixed4 tex = SampleSpriteTexture(IN.texcoord) * IN.color;
fixed Lum = dot(tex, float3(0.2126, 0.7152, 0.0722));
fixed3 color = lerp(Lum.xxx, tex, _Saturation);
color = color * _Brightness;
color = (color - 0.5) * _Contrast + 0.5;
color.rgb *= tex.a;
return float4(color, tex.a);
}

//----------------------------------------------

ENDCG
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}