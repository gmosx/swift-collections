import XCTest

import CollectionsTests

var tests = [XCTestCaseEntry]()
tests += RingBufferTests.allTests()
XCTMain(tests)
