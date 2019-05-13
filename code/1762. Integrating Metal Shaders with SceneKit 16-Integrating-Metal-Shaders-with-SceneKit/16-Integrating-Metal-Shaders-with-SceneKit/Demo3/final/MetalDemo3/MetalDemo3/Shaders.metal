/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct MyNodeBuffer {
  float4x4 modelTransform;
  float4x4 modelViewTransform;
  float4x4 normalTransform;
  float4x4 modelViewProjectionTransform;
};

typedef struct {
  float4 position [[ attribute(SCNVertexSemanticPosition) ]];
  float3 normal   [[ attribute(SCNVertexSemanticNormal) ]];
} MyVertexInput;

struct SimpleVertex
{
  float4 position [[position]];
};

struct BrickVertex
{
  float4 position [[position]];
  float lightIntensity;
  float2 inputPosition;
};

// Simple Red Shader
vertex SimpleVertex redVertex(MyVertexInput in [[ stage_in ]],
                              constant SCNSceneBuffer& scn_frame [[buffer(0)]],
                              constant MyNodeBuffer& scn_node [[buffer(1)]])
{
  SimpleVertex vert;
  vert.position = scn_node.modelViewProjectionTransform * in.position;
  
  return vert;
}

fragment half4 redFragment(SimpleVertex in [[stage_in]])
{
  half4 color;
  color = half4(1.0 ,0.0 ,0.0, 1.0);
  
  return color;
}

// Brick Shader
constant float SpecularContribution = 0.3;
constant float DiffuseContribution  = 1.0 - SpecularContribution;
constant float3 LightPosition = float3(0.0, -0.7071, -0.7071);

vertex BrickVertex brickVertex(MyVertexInput in [[ stage_in ]],
                               constant SCNSceneBuffer& scn_frame [[buffer(0)]],
                               constant MyNodeBuffer& scn_node [[buffer(1)]])
{
  BrickVertex vert;
  
  float3 transformedPosition = (scn_node.modelViewProjectionTransform * in.position).xyz;
  float3 transformedNormal = normalize((scn_node.modelViewProjectionTransform * float4(in.normal, 0.0)).xyz);
  float3 lightVec   = normalize(LightPosition - transformedPosition);
  float3 reflectVec = reflect(-lightVec, transformedNormal);
  float3 viewVec    = normalize(-transformedPosition);
  float diffuse     = max(dot(lightVec, transformedNormal), 0.0);
  float specular        = 0.0;
  
  if (diffuse > 0.0) {
    specular = dot(reflectVec, viewVec);
    specular = pow(specular, 16.0);
  }
  
  float lightIntensity = DiffuseContribution * diffuse + SpecularContribution * specular;
  float2 inputPosition = in.position.xy;
  
  vert.position = scn_node.modelViewProjectionTransform * in.position;
  vert.lightIntensity = lightIntensity;
  vert.inputPosition = inputPosition;
  
  return vert;
}

constant float3 BrickColor = float3(0.52, 0.12, 0.15);
constant float3 MortarColor = float3(0.91, 0.90, 0.90);
constant float2 BrickSize = float2(0.3, 0.15);
constant float2 BrickPct = float2(0.9, 0.85);

fragment half4 brickFragment(BrickVertex in [[stage_in]])
{
  half4 returnColor;
  float3 color;
  float2 position, useBrick;
  
  position = in.inputPosition / BrickSize;
  
  if (fract(position.y * 0.5) > 0.5) {
    position.x += 0.5;
  }
  
  position = fract(position);
  
  useBrick = step(position, BrickPct);
  
  color = mix(MortarColor, BrickColor, useBrick.x * useBrick.y);
  color *= in.lightIntensity * 1.5;
  returnColor = half4(half3(color), 1.0);
  
  return returnColor;
}
