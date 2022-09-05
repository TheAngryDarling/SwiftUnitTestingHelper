//
//  XCTAssertsContainsNotContains.swift
//  UnitTestingHelper
//
//  Created by Tyler Anger on 2021-11-16.
//

import XCTest

/// Tests whether or not the collection contains an element

private func _XCTAssertsContains<C>(collection: C,
                                    message: String,
                                    failureObjectDescription: String,
                                    file: StaticString,
                                    line: UInt,
                                    where condition: (C.Element) throws -> Bool) rethrows -> Bool where C : Collection  {
    var msg = "["
    for (index, val) in collection.enumerated() {
        if index > 0 { msg += ", " }
        msg += "\(val)"
        if try condition(val) { return true }
    }
    
    msg += "] does not contain \(failureObjectDescription)"
    if !message.isEmpty {
        msg += " - " + message
    }
    XCTFail(msg, file: file, line: line)
    return false
}

private func _XCTAssertsNotContains<C>(collection: C,
                                       message: String,
                                       failureObjectDescription: String,
                                       file: StaticString,
                                       line: UInt,
                                       where condition: (C.Element) throws -> Bool) rethrows -> Bool where C : Collection  {
    var msg = "["
    
    var workingIndex = collection.startIndex
    while workingIndex < collection.endIndex {
        let val = collection[workingIndex]
        workingIndex = collection.index(after: workingIndex)
        
        if msg != "[" { msg += ", " }
        msg += "\(val)"
        if try condition(val) {
            if workingIndex < collection.endIndex {
                msg += ", " + collection[workingIndex..<collection.endIndex].map({ return "\($0)" }).joined(separator: ", ")
            }
            msg += "] does contains \(failureObjectDescription)"
            if !message.isEmpty {
                msg += " - " + message
            }
            XCTFail(msg, file: file, line: line)
            return false
        }
    }
    return true
}

#if swift(>=5.3)
/// Tests whether or not the collection contains a condition
@discardableResult
public func XCTAssertsContains<C>(_ expression1: @autoclosure () throws -> C,
                                  _ message: @autoclosure () -> String = "",
                                  file: StaticString = #filePath,
                                  line: UInt = #line,
                                  where condition: (C.Element) throws -> Bool) rethrows -> Bool where C : Collection  {
    
    return try _XCTAssertsContains(collection: try expression1(),
                                   message: message(),
                                   failureObjectDescription: "condition requirements",
                                   file: file,
                                   line: line,
                                   where: condition)
}

/// Tests whether or not the collection contains an element
@discardableResult
public func XCTAssertsContains<C>(_ expression1: @autoclosure () throws -> C,
                                  _ expression2: @autoclosure () throws -> C.Element,
                                  _ message: @autoclosure () -> String = "",
                                  file: StaticString = #filePath,
                                  line: UInt = #line) rethrows -> Bool where C : Collection, C.Element: Equatable  {
    
    let e2 = try expression2()
    
    return _XCTAssertsContains(collection: try expression1(),
                                   message: message(),
                                   failureObjectDescription: "'\(e2)'",
                                   file: file,
                                   line: line) { e in
        return e == e2
    }
}

/// Tests whether or not the collection does not contains a condition
@discardableResult
public func XCTAssertsNotContains<C>(_ expression1: @autoclosure () throws -> C,
                                  _ message: @autoclosure () -> String = "",
                                  file: StaticString = #filePath,
                                  line: UInt = #line,
                                  where condition: (C.Element) throws -> Bool) rethrows -> Bool where C : Collection  {
    
    return try _XCTAssertsNotContains(collection: try expression1(),
                                   message: message(),
                                   failureObjectDescription: "condition requirements",
                                   file: file,
                                   line: line,
                                   where: condition)
}
/// Tests whether or not the collection does not contains an element
@discardableResult
public func XCTAssertsNotContains<C>(_ expression1: @autoclosure () throws -> C,
                                     _ expression2: @autoclosure () throws -> C.Element,
                                     _ message: @autoclosure () -> String = "",
                                     file: StaticString = #filePath,
                                     line: UInt = #line) rethrows -> Bool where C : Collection, C.Element: Equatable  {
    let e2 = try expression2()
    
    return _XCTAssertsNotContains(collection: try expression1(),
                                  message: message(),
                                  failureObjectDescription: "'\(e2)'",
                                  file: file,
                                  line: line) { e in
        return e == e2
    }
}
#else
/// Tests whether or not the collection contains a condition
@discardableResult
public func XCTAssertsContains<C>(_ expression1: @autoclosure () throws -> C,
                                  _ message: @autoclosure () -> String = "",
                                  file: StaticString = #file,
                                  line: UInt = #line,
                                  where condition: (C.Element) throws -> Bool) rethrows -> Bool where C : Collection  {
    
    return try _XCTAssertsContains(collection: try expression1(),
                                   message: message(),
                                   failureObjectDescription: "condition requirements",
                                   file: file,
                                   line: line,
                                   where: condition)
}

/// Tests whether or not the collection contains an element
@discardableResult
public func XCTAssertsContains<C>(_ expression1: @autoclosure () throws -> C,
                                  _ expression2: @autoclosure () throws -> C.Element,
                                  _ message: @autoclosure () -> String = "",
                                  file: StaticString = #file,
                                  line: UInt = #line) rethrows -> Bool where C : Collection, C.Element: Equatable  {
    
    let e2 = try expression2()
    
    return _XCTAssertsContains(collection: try expression1(),
                                   message: message(),
                                   failureObjectDescription: "'\(e2)'",
                                   file: file,
                                   line: line) { e in
        return e == e2
    }
}

/// Tests whether or not the collection does not contains a condition
@discardableResult
public func XCTAssertsNotContains<C>(_ expression1: @autoclosure () throws -> C,
                                  _ message: @autoclosure () -> String = "",
                                  file: StaticString = #file,
                                  line: UInt = #line,
                                  where condition: (C.Element) throws -> Bool) rethrows -> Bool where C : Collection  {
    
    return try _XCTAssertsNotContains(collection: try expression1(),
                                   message: message(),
                                   failureObjectDescription: "condition requirements",
                                   file: file,
                                   line: line,
                                   where: condition)
}
/// Tests whether or not the collection does not contains an element
@discardableResult
public func XCTAssertsNotContains<C>(_ expression1: @autoclosure () throws -> C,
                                     _ expression2: @autoclosure () throws -> C.Element,
                                     _ message: @autoclosure () -> String = "",
                                     file: StaticString = #file,
                                     line: UInt = #line) rethrows -> Bool where C : Collection, C.Element: Equatable  {
    let e2 = try expression2()
    
    return _XCTAssertsNotContains(collection: try expression1(),
                                  message: message(),
                                  failureObjectDescription: "'\(e2)'",
                                  file: file,
                                  line: line) { e in
        return e == e2
    }
}
#endif
