//
//  XCTAssertsNilNotNIl.swift
//  UnitTestingHelper
//
//  Created by Tyler Anger on 2020-12-02.
//

import XCTest

#if swift(>=5.3)
/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
@discardableResult
public func XCTAssertsNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #filePath,
                        line: UInt = #line,
                        onNotNil: (T, StaticString, UInt) -> Void = {_,_,_ in return}) rethrows -> Bool {
    let e1 = try expression()
    
    XCTAssertNil(e1, message, file: file, line: line)
    if let e = e1 { onNotNil(e, file, line) }
    
    return e1 == nil
}
/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
@discardableResult
public func XCTAssertsNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #filePath,
                        line: UInt = #line,
                        onNotNil: (T) -> Void) rethrows -> Bool {
    return XCTAssertsNil(try expression(),
                         message(),
                         file: file,
                         line: line) {val, _, _ in
        onNotNil(val)
    }
}

/// Same as its XCTAssert equivilant but will return results from the expression
@discardableResult
public func XCTAssertsNotNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #filePath,
                        line: UInt = #line) rethrows -> T? {
    let e1 = try expression()
    
    XCTAssertNotNil(e1, message, file: file, line: line)
    
    return e1
}
#else
/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
@discardableResult
public func XCTAssertsNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line,
                        onNotNil: (T, StaticString, UInt) -> Void = {_,_,_ in return}) rethrows -> Bool {
    let e1 = try expression()
    
    XCTAssertNil(e1, message, file: file, line: line)
    if let e = e1 { onNotNil(e, file, line) }
    
    return e1 == nil
}

/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
@discardableResult
public func XCTAssertsNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line,
                        onNotNil: (T) -> Void) rethrows -> Bool {
    
    return try XCTAssertsNil(try expression(),
                             message(),
                             file: file,
                             line:line) { val, _, _ in
        onNotNil(val)
    }
}

/// Same as its XCTAssert equivilant but will return results from the expression
@discardableResult
public func XCTAssertsNotNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) rethrows -> T? {
    let e1 = try expression()
    
    XCTAssertNotNil(e1, message, file: file, line: line)
    
    return e1
}
#endif
