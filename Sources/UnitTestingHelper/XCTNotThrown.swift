//
//  XCTNotThrown.swift
//  UnitTestingHelper
//
//  Created by Tyler Anger on 2020-10-29.
//

import XCTest

/// Failure on thrown exception and returns nil OR returns results from block
/// - Parameters:
///   - block: The block to execute
///   - message: Message to display on thrown error
///   - file: File of code being called
///   - line: Line in code being called
///   - onError: Callback to execute when an error is thrown
/// - Returns: Returns nil of error thrown or results from block method
@discardableResult
public func XCTNotThrown<R>(_ block: @autoclosure () throws -> R,
                            _ message: @autoclosure () -> String = "",
                            file: StaticString = #file,
                            line: UInt = #line,
                            onError: (Error) -> Void = { _ in return }) -> R? {
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
