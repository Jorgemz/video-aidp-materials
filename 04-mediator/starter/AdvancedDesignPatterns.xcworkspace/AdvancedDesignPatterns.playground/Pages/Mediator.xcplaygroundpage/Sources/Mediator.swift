/// Copyright (c) 2020 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

open class Mediator<T> {
  
  private class ColleagueWrapper {
    var strongColleague: AnyObject?
    weak var weakColleague: AnyObject?
    
    var colleague: T? {
      return (weakColleague ?? strongColleague) as? T
    }
    
    init(weakColleague: T) {
      self.strongColleague = nil
      self.weakColleague = weakColleague as AnyObject
    }
    
    init(strongColleague: T) {
      self.strongColleague = strongColleague  as AnyObject
      self.weakColleague = nil
    }
  }
  
  // MARK: - Instance Properties
  private var colleagueWrappers: [ColleagueWrapper] = []
  
  public var colleagues: [T] {
    colleagueWrappers.compactMap({$0.colleague})
  }
  
  // MARK: - Object Lifecycle
  public init() { }
  
  // MARK: - Colleague Management
  public func addColleague(_ colleague: T,
                           strongReference: Bool = true) {
    let wrapper: ColleagueWrapper =
    strongReference ?
      ColleagueWrapper(strongColleague: colleague)
    :
      ColleagueWrapper(weakColleague: colleague)
    colleagueWrappers.append(wrapper)
  }
  
  public func removeColleague(_ colleague: T) {
    guard let index = colleagues.firstIndex(where: {
      ($0 as AnyObject) === (colleague as AnyObject)
    }) else { return }
    colleagueWrappers.remove(at: index)
  }
  
  public func invokeColleagues(closure: (T) -> Void) {
    colleagues.forEach(closure)
  }
  
  public func invokeColleagues(by colleague: T,
                               closure: (T) -> Void) {
    colleagues.forEach {
      guard ($0 as AnyObject) !== (colleague as AnyObject)
        else { return }
      closure($0)
    }
  }
}
