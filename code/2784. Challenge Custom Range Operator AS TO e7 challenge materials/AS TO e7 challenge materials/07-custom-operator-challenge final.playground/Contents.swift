// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

infix operator +/-: RangeFormationPrecedence

@inlinable func +/-<T: FloatingPoint>(lhs: T, rhs: T) -> ClosedRange<T> {
  let positive = abs(rhs)
  return ClosedRange(uncheckedBounds: (lower: lhs-positive, upper: lhs+positive))
}

let aboutThree = 3.0 +/- 0.5
aboutThree.contains(2.7)
