//
//  XCTAssertsGreaterThanLessThan.swift
//  UnitTestingHelper
//
//  Created by Tyler Anger on 2020-12-02.
//

import XCTest

/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
public func XCTAssertsGreaterThan<T>(_ expression1: @autoclosure () throws -> T,
                        _ expression2: @autoclosure () throws -> T,
                        _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) rethrows -> Bool where T : Comparable {
    let e1 = try expression1()
    let e2 = try expression2()
    
    XCTAssertGreaterThan(e1, e2, message, file: file, line: line)
    
    return e1 > e2
}

/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
public func XCTAssertsGreaterThanOrEqual<T>(_ expression1: @autoclosure () throws -> T,
                        _ expression2: @autoclosure () throws -> T,
                        _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) rethrows -> Bool where T : Comparable {
    let e1 = try expression1()
    let e2 = try expression2()
    
    XCTAssertGreaterThanOrEqual(e1, e2, message, file: file, line: line)
    
    return e1 >= e2
}

/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
public func XCTAssertsLessThan<T>(_ expression1: @autoclosure () throws -> T,
                        _ expression2: @autoclosure () throws -> T,
                        _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) rethrows -> Bool where T : Comparable {
    let e1 = try expression1()
    let e2 = try expression2()
    
    XCTAssertLessThan(e1, e2, message, file: file, line: line)
    
    return e1 < e2
}

/// Same as its XCTAssert equivilant but will return a bool indicator if the test passed or not
public func XCTAssertsLessThanOrEqual<T>(_ expression1: @autoclosure () throws -> T,
                        _ expression2: @autoclosure () throws -> T,
                        _ message: @autoclosure () -> String = "",
                        file: StaticString = #file,
                        line: UInt = #line) rethrows -> Bool where T : Comparable {
    let e1 = try expression1()
    let e2 = try expression2()
    
    XCTAssertLessThanOrEqual(e1, e2, message, file: file, line: line)
    
    return e1 <= e2
}
