/// Copyright (c) 2019 Razeware LLC
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

#import "Common.h"

constant float3 lightPosition = float3(2.0, 1.0, 0);
constant float3 ambientLightColor = float3(1.0, 1.0, 1.0);
constant float ambientLightIntensity = 0.3;
constant float3 lightSpecularColor = float3(1.0, 1.0, 1.0);

constant float3 color[6] = {
  float3(1, 0, 0),
  float3(0, 1, 0),
  float3(0, 0, 1),
  float3(0, 0, 1),
  float3(0, 1, 0),
  float3(1, 0, 1)
};

struct VertexOut {
  float4 position [[position]];
  float3 color;
  float3 worldNormal;
  float3 worldPosition;
};

struct VertexIn {
  float4 position [[attribute(0)]];
  float3 normal [[attribute(1)]];
};

vertex VertexOut vertex_main(VertexIn vertexBuffer [[stage_in]],
                             constant uint &colorIndex [[buffer(11)]],
                             constant Uniforms &uniforms [[buffer(21)]]) {
  VertexOut out {
    .position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * vertexBuffer.position,
    .color = color[colorIndex],
    .worldNormal = (uniforms.modelMatrix * float4(vertexBuffer.normal, 0)).xyz,
    .worldPosition = (uniforms.modelMatrix * vertexBuffer.position).xyz,
  };
  return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]],
                              constant FragmentUniforms &fragmentUniforms [[ buffer(22)]]) {
  float materialShininess = 32;
  float3 materialSpecularColor = float3(1, 1, 1);

  float3 lightVector = normalize(lightPosition);
  float3 normalVector = normalize(in.worldNormal);
  float3 reflection = reflect(lightVector, normalVector);
  float3 cameraVector = normalize(in.worldPosition - fragmentUniforms.cameraPosition);

  float3 baseColor = in.color;
  float diffuseIntensity = saturate(dot(lightVector, normalVector));
  
  float3 diffuseColor = baseColor * diffuseIntensity;
  
  float3 ambientColor = baseColor * ambientLightColor * ambientLightIntensity ;
  
  float specularIntensity = pow(saturate(dot(reflection, cameraVector)), materialShininess);
  float3 specularColor = lightSpecularColor * materialSpecularColor * specularIntensity;

  float3 color = diffuseColor + ambientColor + specularColor;
  return float4(color, 1);

  return float4(normalize(in.worldNormal), 1);
}
