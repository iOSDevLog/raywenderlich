/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import MetalKit

class Cube: Primitive {

  override func buildVertices() {
    vertices = [
      Vertex(position: float3(-1, 1, 1),   // 0 Front
             color:    float4(1, 0, 0, 1),
             texture:  float2(0, 0)),
      Vertex(position: float3(-1, -1, 1),  // 1
             color:    float4(0, 1, 0, 1),
             texture:  float2(0, 1)),
      Vertex(position: float3(1, -1, 1),   // 2
             color:    float4(0, 0, 1, 1),
             texture:  float2(1, 1)),
      Vertex(position: float3(1, 1, 1),    // 3
             color:    float4(1, 0, 1, 1),
             texture:  float2(1, 0)),
      
      Vertex(position: float3(-1, 1, -1),  // 4 Back
             color:    float4(0, 0, 1, 1),
             texture:  float2(1, 1)),
      Vertex(position: float3(-1, -1, -1), // 5
             color:    float4(0, 1, 0, 1),
             texture:  float2(0, 1)),
      Vertex(position: float3(1, -1, -1),  // 6
             color:    float4(1, 0, 0, 1),
             texture:  float2(0, 0)),
      Vertex(position: float3(1, 1, -1),   // 7
             color:    float4(1, 0, 1, 1),
             texture:  float2(1, 0)),
    ]
    
    indices = [
      0, 1, 2,     0, 2, 3,  // Front
      4, 6, 5,     4, 7, 6,  // Back

      4, 5, 1,     4, 1, 0,  // Left
      3, 6, 7,     3, 2, 6,  // Right

      4, 0, 3,     4, 3, 7,  // Top
      1, 5, 6,     1, 6, 2   // Bottom
    ]
  }
}
