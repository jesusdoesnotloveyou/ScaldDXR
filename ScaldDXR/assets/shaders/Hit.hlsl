#include "Common.hlsl"

struct STriVertex
{
    float3 vertex;
    float4 color;
};

StructuredBuffer<STriVertex> BTriVertex : register(t0);

[shader("closesthit")] 
void ClosestHit(inout HitInfo payload, Attributes attrib)
{
    // v0 = 1 - a - b, v1 = a, v2 = b
    float3 barycentrics = float3(1.0f - attrib.barycentric.x - attrib.barycentric.y, attrib.barycentric.x, attrib.barycentric.y);
 
    uint vertId = 3 * PrimitiveIndex();
    float3 hitColor = BTriVertex[vertId + 0].color * barycentrics.x +
                      BTriVertex[vertId + 1].color * barycentrics.y +
                      BTriVertex[vertId + 2].color * barycentrics.z;
    
    //hitColor = barycentrics.x * float3(1.0f, 0.0f, 0.0f) + barycentrics.y * float3(0.0f, 1.0f, 0.0f) + barycentrics.z * float3(0.0f, 0.0f, 1.0f);
    payload.colorAndDistance = float4(hitColor, RayTCurrent());
}
