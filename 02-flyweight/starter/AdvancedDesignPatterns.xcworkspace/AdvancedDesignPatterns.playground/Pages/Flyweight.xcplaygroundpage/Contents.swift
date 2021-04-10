
/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Flyweight
 - - - - - - - - - -
 ![Flyweight Diagram](Flyweight_Diagram.png)
 
 The Flyweight Pattern is a structural design pattern that minimizes memory usage and processing.
 
 The flyweight pattern provides a shared instance that allows other instances to be created too. Every reference to the class refers to the same underlying instance.
 
 ## Code Example
 */
import UIKit
import os

let logger = Logger(subsystem: "com.dserweb.flyweight", category: "flyweight")

let red = UIColor.red
let red2 = UIColor.red
print(red === red2)

extension UIColor {
  public static var colorStore: [String: UIColor] = [:]
  public class func rgba(_ red: CGFloat,
                         _ green: CGFloat,
                         _ blue: CGFloat,
                         _ alpha: CGFloat) -> UIColor {
    let key = "\(red)\(green)\(alpha)"
    if let color = colorStore[key] { return color }
    let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    colorStore[key] = color
    return color
  }
}

let color1 = UIColor.rgba(1, 0, 0, 1)
let color2 = UIColor.rgba(1, 0, 0, 1)
print(color1 === color2)
