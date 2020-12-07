//
//  XCTAssertsNilNotNIl.swift
//  UnitTestingHelper
//
//  Created by Tyler Anger on 2020-12-02.
//

import XCTest

/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
@discardableResult
public func XCTAssertsNil<T>(_ expression: @autoclosure () throws -> T?,
                       _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line,
                        onNotNil: (T) -> Void = {_ in return}) rethrows -> Bool {
    let e1 = try expression()
    
    XCTAssertNil(e1, message, file: file, line: line)
    if let e = e1 { onNotNil(e) }
    
    return e1 == nil
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
