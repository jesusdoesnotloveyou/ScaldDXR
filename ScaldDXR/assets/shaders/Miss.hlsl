#include "Common.hlsl"

// This shader will be executed when no geometry is hit, and will write a constant color in the payload.
// Note that this shader takes the payload as a inout parameter.
// It will be provided to the shader automatically by DXR.
[shader("miss")]
void Miss(inout HitInfo payload : SV_RayPayload)
{
    uint2 launchIndex = DispatchRaysIndex().xy;
    float2 dims = DispatchRaysDimensions();
    float2 uv = (launchIndex + 0.5f) / dims;
 
    float ramp = launchIndex.y / dims.y;
    
    float3 missColor = float3(uv.y, uv.x, 1.0f - 0.6f * ramp);
    //payload.colorAndDistance = float4(missColor, -1.0f);
    payload.colorAndDistance = float4(uv, 0.0f, -1.0f);
}