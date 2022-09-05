import XCTest
@testable import UnitTestingHelper

class UnitTestingHelperTests: XCExtenedTestCase {
    
    override class func setUp() {
        super.setUp()
        initTestingFile()
        // Testing static print to ensure we don't get
        // swift error about calling instance method statically
        print("Testing static print func")
    }
    
    var _canPrint: Bool = true
    override var canPrint: Bool { return _canPrint }
    
    var _canVerbosePrint: Bool = true
    override var canVerbosePrint: Bool { return _canVerbosePrint }
    
    var _canDebugPrint: Bool = true
    override var canDebugPrint: Bool { return _canDebugPrint }
    
    func getSourcePath(source: StaticString = #file) -> String {
        return "\(source)"
    }
    func testPaths() {
        let unitTestName = "UnitTestingHelperTests"
        let sourcePath = getSourcePath()
        var testTargetPath = sourcePath
        guard let r = testTargetPath.range(of: "/\(unitTestName)/") else {
            XCTFail("Unable to find test target folder '\(unitTestName)' in path '\(testTargetPath)'")
            return
        }
        testTargetPath = String(testTargetPath[..<r.upperBound])
        let testTargetURL =  URL(fileURLWithPath: testTargetPath,
                                     isDirectory: true)
        let testsURL = testTargetURL.deletingLastPathComponent()
        
        let projectURL = testsURL.deletingLastPathComponent()
        
        
        XCTAssertEqual(self.projectURL, projectURL)
        XCTAssertEqual(self.testsURL, testsURL)
        XCTAssertEqual(self.testTargetURL, testTargetURL)
        XCTAssertEqual(self.testTargetName, unitTestName)
        
       
    }
    
    func testPrints() {
        
        var testWithoutPrint: String = ""
        self.withoutPrint {
            print("Project URL: \(self.projectURL)", to: &testWithoutPrint)
            print("Project URL: \(UnitTestingHelperTests.projectURL)", to: &testWithoutPrint)
            print("Tests URL: \(self.testsURL)", to: &testWithoutPrint)
            print("Tests URL: \(UnitTestingHelperTests.testsURL)", to: &testWithoutPrint)
            print("Test Target URL: \(self.testTargetURL)", to: &testWithoutPrint)
            print("Test Target URL: \(UnitTestingHelperTests.testTargetURL)", to: &testWithoutPrint)
        }
        XCTAssertTrue(testWithoutPrint.isEmpty)
        // Change defaul state
        self._canPrint = false
        
        var testWithPrint: String = ""
        self.withPrint {
            print("Project URL: \(self.projectURL)", to: &testWithPrint)
            print("Project URL: \(UnitTestingHelperTests.projectURL)", to: &testWithPrint)
            print("Tests URL: \(self.testsURL)", to: &testWithPrint)
            print("Tests URL: \(UnitTestingHelperTests.testsURL)", to: &testWithPrint)
            print("Test Target URL: \(self.testTargetURL)", to: &testWithPrint)
            print("Test Target URL: \(UnitTestingHelperTests.testTargetURL)", to: &testWithPrint)
        }
        XCTAssertTrue(!testWithPrint.isEmpty)
        
    }
    
    func testVerbosePrints() {
        
        var testWithoutPrint: String = ""
        self.withoutVerbosePrint {
            verbosePrint("Project URL: \(self.projectURL)", to: &testWithoutPrint)
            verbosePrint("Project URL: \(UnitTestingHelperTests.projectURL)", to: &testWithoutPrint)
            verbosePrint("Tests URL: \(self.testsURL)", to: &testWithoutPrint)
            verbosePrint("Tests URL: \(UnitTestingHelperTests.testsURL)", to: &testWithoutPrint)
            verbosePrint("Test Target URL: \(self.testTargetURL)", to: &testWithoutPrint)
            verbosePrint("Test Target URL: \(UnitTestingHelperTests.testTargetURL)", to: &testWithoutPrint)
        }
        XCTAssertTrue(testWithoutPrint.isEmpty)
        // Change defaul state
        self._canVerbosePrint = false
        
        var testWithPrint: String = ""
        self.withVerbosePrint {
            verbosePrint("Project URL: \(self.projectURL)", to: &testWithPrint)
            verbosePrint("Project URL: \(UnitTestingHelperTests.projectURL)", to: &testWithPrint)
            verbosePrint("Tests URL: \(self.testsURL)", to: &testWithPrint)
            verbosePrint("Tests URL: \(UnitTestingHelperTests.testsURL)", to: &testWithPrint)
            verbosePrint("Test Target URL: \(self.testTargetURL)", to: &testWithPrint)
            verbosePrint("Test Target URL: \(UnitTestingHelperTests.testTargetURL)", to: &testWithPrint)
        }
        XCTAssertTrue(!testWithPrint.isEmpty)
        
    }
    
    func testDebugPrints() {
        
        var testWithoutPrint: String = ""
        self.withoutDebugPrint {
            debugPrint("Project URL: \(self.projectURL)", to: &testWithoutPrint)
            debugPrint("Project URL: \(UnitTestingHelperTests.projectURL)", to: &testWithoutPrint)
            debugPrint("Tests URL: \(self.testsURL)", to: &testWithoutPrint)
            debugPrint("Tests URL: \(UnitTestingHelperTests.testsURL)", to: &testWithoutPrint)
            debugPrint("Test Target URL: \(self.testTargetURL)", to: &testWithoutPrint)
            debugPrint("Test Target URL: \(UnitTestingHelperTests.testTargetURL)", to: &testWithoutPrint)
        }
        XCTAssertTrue(testWithoutPrint.isEmpty)
        // Change defaul state
        self._canDebugPrint = false
        
        var testWithPrint: String = ""
        self.withDebugPrint {
            debugPrint("Project URL: \(self.projectURL)", to: &testWithPrint)
            debugPrint("Project URL: \(UnitTestingHelperTests.projectURL)", to: &testWithPrint)
            debugPrint("Tests URL: \(self.testsURL)", to: &testWithPrint)
            debugPrint("Tests URL: \(UnitTestingHelperTests.testsURL)", to: &testWithPrint)
            debugPrint("Test Target URL: \(self.testTargetURL)", to: &testWithPrint)
            debugPrint("Test Target URL: \(UnitTestingHelperTests.testTargetURL)", to: &testWithPrint)
        }
        XCTAssertTrue(!testWithPrint.isEmpty)
        
    }
    
    func testAnyPrints() {
        
        var testWithoutPrint: String = ""
        self.withoutAnyPrint {
            print("Project URL: \(self.projectURL)", to: &testWithoutPrint)
            verbosePrint("Project URL: \(UnitTestingHelperTests.projectURL)",
                         to: &testWithoutPrint)
            debugPrint("Tests URL: \(self.testsURL)", to: &testWithoutPrint)
            print("Tests URL: \(UnitTestingHelperTests.testsURL)",
                  to: &testWithoutPrint)
            verbosePrint("Test Target URL: \(self.testTargetURL)",
                         to: &testWithoutPrint)
            debugPrint("Test Target URL: \(UnitTestingHelperTests.testTargetURL)",
                       to: &testWithoutPrint)
        }
        XCTAssertTrue(testWithoutPrint.isEmpty)
        // Change defaul states
        self._canPrint = false
        self._canVerbosePrint = false
        self._canDebugPrint = false
        
        var testWithPrint: String = ""
        self.withAnyPrint {
            print("Project URL: \(self.projectURL)", to: &testWithPrint)
            verbosePrint("Project URL: \(UnitTestingHelperTests.projectURL)",
                         to: &testWithPrint)
            debugPrint("Tests URL: \(self.testsURL)", to: &testWithPrint)
            print("Tests URL: \(UnitTestingHelperTests.testsURL)",
                  to: &testWithPrint)
            verbosePrint("Test Target URL: \(self.testTargetURL)",
                         to: &testWithPrint)
            debugPrint("Test Target URL: \(UnitTestingHelperTests.testTargetURL)",
                       to: &testWithPrint)
        }
        XCTAssertTrue(!testWithPrint.isEmpty)
        
    }
    
    func testAsserts() {
        
        func onThrowsOld(_ err: Error) {
            print(err)
        }
        
        func onThrowsNew(_ err: Error, _ file: StaticString, _ line: UInt) {
            
        }
        
        let testIntValue = 7
        let testNotEqualValue = 100
        let testLessThanValue = 2
        let testGreaterThanValue = 10
        enum Errors: Swift.Error {
            case err
        }
        func throwsFunc() throws -> Int {
            throw Errors.err
        }
        func nothrowsFunc() throws -> Int {
            return testIntValue
        }
        func nothrowsVoidFunc() throws { }
        
        func nothrowsOptWithValueFunc() throws -> Int? {
            return testIntValue
        }
        
        func nothrowsOptWithoutValueFunc() throws -> Int? {
            return nil
        }
        
        #if !DOCKER_ALL_BUILD
        // Expects warning here for XCTNotThrown because its deprecated and has been renamed XCTAssertsNoThrow
        if let _ = XCTNotThrown(try nothrowsFunc()) {
            
        }
        #endif
        
        if let e = XCTAssertsThrow(try throwsFunc()) {
            if let er = e as? Errors {
                if case .err = er {
                    
                }
            }
        }
        
        if XCTAssertsNoThrow(try nothrowsOptWithValueFunc()) == nil {
            XCTFail("Expected return value from XCTAssertsNoThrow")
        }
        
        if XCTAssertsNoThrow(try nothrowsOptWithoutValueFunc()) != nil {
            XCTFail("Expected nil value from XCTAssertsNoThrow")
        }
        
        if let v = XCTAssertsNoThrow(try nothrowsFunc(), onError: { e in return }) {
            
            // Testing new XCTAssertsNoThrow( () throws -> Void) -> Bool
            if XCTAssertsNoThrow(try nothrowsVoidFunc(), onError: { e, file, line in return }) {
                // Testing to make sure no ambigious calls
                XCTAssertsNoThrow(try nothrowsFunc(), onError: onThrowsOld)
                XCTAssertsNoThrow(try nothrowsVoidFunc(), onError: onThrowsNew)
            }
            if XCTAsserts(v == testIntValue) {
                
            }
            if XCTAssertsTrue(v == testIntValue) {
                
            }
            if XCTAssertsFalse(v == testNotEqualValue) {
                
            }
            
            if XCTAssertsEqual(v, testIntValue) {
                
            }
            if XCTAssertsNotEqual(v, testNotEqualValue) {
                
            }
            
            if XCTAssertsGreaterThan(v, testLessThanValue) {
                
            }
            if XCTAssertsGreaterThanOrEqual(v, testLessThanValue) {
                
            }
            
            if XCTAssertsLessThan(v, testGreaterThanValue) {
                
            }
            if XCTAssertsLessThanOrEqual(v, testGreaterThanValue) {
                
            }
        }
        
        if let _ = XCTAssertsNotNil(Optional<Int>.some(testIntValue)) {
            
        }
        
        if XCTAssertsNil(Optional<Int>.none) {
            
        }
    }
    
    func testPrintSeparatorRename() {
        self._canPrint = false
        #if !DOCKER_ALL_BUILD
        // Testing rename warning
        self.print("Message", seperator: " ")
        #endif
        self.print("Message 2", separator: " ")
    }


    static var allTests = [
        ("testPaths", testPaths),
        ("testPrints", testPrints),
        ("testVerbosePrints", testVerbosePrints),
        ("testAnyPrints", testAnyPrints),
        ("testAsserts", testAsserts),
        ("testPrintSeparatorRename", testPrintSeparatorRename)
    ]
}
