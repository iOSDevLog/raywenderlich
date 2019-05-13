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

import simd

// http://stackoverflow.com/questions/470690/how-to-automatically-generate-n-distinct-colors
func color(number: Float) -> float4 {
  var x = number
  var r: Float = 0.0
  var g: Float = 0.0
  var b: Float = 1.0
  
  if x >= 0.0 && x < 0.2 {
    x = x / 0.2
    r = 0.0
    g = x
    b = 1.0
  } else if x >= 0.2 && x < 0.4 {
    x = (x - 0.2) / 0.2
    r = 0.0
    g = 1.0
    b = 1.0 - x
  } else if x >= 0.4 && x < 0.6 {
    x = (x - 0.4) / 0.2
    r = x
    g = 1.0
    b = 0.0
  } else if x >= 0.6 && x < 0.8 {
    x = (x - 0.6) / 0.2
    r = 1.0
    g = 1.0 - x
    b = 0.0
  } else if x >= 0.8 && x <= 1.0 {
    x = (x - 0.8) / 0.2
    r = 1.0
    g = 0.0
    b = x
  }
  return float4(r, g, b, 1.0)
}

func generateColors(number: Int) -> [float4] {
  var colors = [float4](repeating: float4(0), count: number)
  for i in 0..<number {
    colors[i] = color(number: (Float(number - i)) / Float(number))
  }
  return colors
}



