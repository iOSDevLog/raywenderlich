import UIKit
/*:
## Axis and Tick Calculations

A tick is represented by the following struct:
```
struct Tick {
    let position: CGFloat
    let value: CGFloat
    let labelValue: String
}
```

The **position** is the proportional position on the axis, the **value** is the numeric value that the tick represents, and the **labelValue** is the formatted value which will be used to label the tick on the axis.

 An axis is represented by this struct:

 ```
struct Axis {
    let valueRange: ClosedRange<CGFloat>
    let ticks: [Tick]
}
```

**valueRange** represents the largest and smallest values on the axis, and **ticks** is an array of `Tick`s.
 
An extension to `ClosedRange<CGFloat>` has been added which will derive an axis from a given range of values.
*/






























