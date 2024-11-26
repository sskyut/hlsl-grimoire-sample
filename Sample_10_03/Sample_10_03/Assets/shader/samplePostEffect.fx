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

Texture2D<float4> sceneTexture : register(t0); // シーンテクスチャ
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

    // step-1 基準テクセル+近傍8テクセルの平均を計算する
    // 2.5テクセルずらすためのUV値を求める
    float offsetU = 1.5f / 1280.0f;
    float offsetV = 1.5f / 720.0f;

    // 基準テクセルから右テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(offsetU, 0.0f));

    // 基準テクセルから左テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(-offsetU, 0.0f));

    // 基準テクセルから下テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(0.0f, offsetV));

    // 基準テクセルから上テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(0.0f, -offsetV));

    // 基準テクセルから右下テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(offsetU, offsetV));

    // 基準テクセルから右上テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(offsetU, -offsetV));

    // 基準テクセルから左下テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(-offsetU, offsetV));

    // 基準テクセルから左上テクセルのカラーをサンプリングする
    color += sceneTexture.Sample(Sampler, In.uv + float2(-offsetU, -offsetV));

    // 基準テクセルから左上テクセルのカラーをサンプリングする
    color /= 9.0f;

    return color;
}
