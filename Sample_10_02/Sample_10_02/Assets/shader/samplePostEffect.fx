cbuffer cb : register(b0)
{
	float4x4 mvp;       // MVP行列
	float4 mulColor;    // 乗算カラー
};

struct VSInput
{
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

struct PSInput
{
	float4 pos : SV_POSITION;
	float2 uv  : TEXCOORD0;
};

Texture2D<float4> sceneTexture : register(t0);  // シーンテクスチャ
sampler Sampler : register(s0);

PSInput VSMain(VSInput In)
{
	PSInput psIn;
	psIn.pos = mul(mvp, In.pos);
	psIn.uv = In.uv;
	return psIn;
}

float4 PSMain(PSInput In) : SV_Target0
{
	float4 color = sceneTexture.Sample(Sampler, In.uv);

	// step-7 ピクセルカラーをモノクロ化する
	float4 Y =  0.299f * color.r + 0.587f * color.b + 0.114f * color.b;
	color.r = Y;
	color.g = Y;
	color.b = Y;

	/* ソラリゼーション?
	color.r = (color.r- 0.5f)* (color.r - 0.5f)/0.25f;
	color.g = (color.g - 0.5f) * (color.g - 0.5f) / 0.25f;
	color.b = (color.b - 0.5f) * (color.b - 0.5f) / 0.25f;
	*/

	return color;
}
