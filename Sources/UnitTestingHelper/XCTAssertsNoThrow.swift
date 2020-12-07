//
//  XCTAssertsNoThrow.swift
//  UnitTestingHelper
//
//  Created by Tyler Anger on 2020-12-02.
//

import XCTest

/// Test to ensure the given block does not throw an error
/// - Parameters:
///   - block: The block to execute
///   - message: Message to display on thrown error
///   - file: File of code being called
///   - line: Line in code being called
///   - onError: Callback to execute when an error is thrown
/// - Returns: Returns nil if error thrown or results from block method
@discardableResult
public func XCTAssertsNoThrow<T>(_ block: @autoclosure () throws -> T,
                                 _ message: @autoclosure () -> String = "",
                                 file: StaticString = #file,
                                 line: UInt = #line,
                                 onError: (Error) -> Void = { _ in return }) -> T? {
    do {
        return try block()
    } catch {
        onError(error)
        var msg: String = message()
        if msg.isEmpty {
            msg = "Test failed with the following error:"
        }
        if !msg.isEmpty { msg += "\n" }
        msg += "\(error)"
        XCTFail(msg, file: file, line: line)
        return nil
    }
}

/// Test to ensure that the given block will throw an error
/// - Parameters:
///   - block: The block to execute
///   - message: Message to display if no error is thrown
///   - file: File of code being called
///   - line: Line in code being called
///   - onNoError: Callback to execute if no error is thrown
/// - Returns: Returns the error that was thrown or nil if no error was thrown
@discardableResult
public func XCTAssertsThrow<T>(_ block: @autoclosure () throws -> T,
                               _ message: @autoclosure () -> String = "",
                               file: StaticString = #file,
                               line: UInt = #line,
                               onNoError: (T) -> Void = { _ in return }) -> Error? {
    do {
        let v = try block()
        onNoError(v)
        var msg: String = message()
        if msg.isEmpty { msg = "Test did not throw an error" }
        XCTFail(msg, file: file, line: line)
        return nil
        
    } catch {
        return error
    }
}
