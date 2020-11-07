# Unit Testing Helper

![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
[![Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=flat)](LICENSE.md)

Provides an extended XCTestCase (XCExtenedTestCase) that gives access to helper methods for printing and accessing the filesystem relative to the project.  This last part comes in handy whey testing on different platforms as files that need to be read from the filesystem can be located relative from the project or test folders instead of using absolute paths.

## XCExtenedTestCase:
>>### Properties:
>>*   **isXcodeTesting**: Indicator if running withing Xcode
>>*   **projectURL**: URL to the current project
>>*   **testsURL**: URL to the projects Tests folder
>>*   **testTargetURL**: URL to the target test folder
>>*   **testTargetName**: Returns the name of the current Test Target
>>*   **canPrint**: Indicator if new print method should output.  This is overridable
>>*   **canVerbosePrint**: Indicator if new verbosePrint method should output.  This is overridable
>>*   **canDebugPrint**: Indicator if new debugPrint method should output.  This is overridable

>>### Methods:
>>*   **print**: Prints text when canPrint returns true
>>*   **verbosePrint**: Prints text when canVerbosePrint returns true
>>*   **debugPrint**: Prints text when canDebugPrint returns true
>>*   **withPrint**: Ignores canPrint when calling print method within block so that it always prints
>>*   **withoutPrint**: Ignores canPrint when calling print method within block so that it never prints
>>*   **withVerbosePrint**: Ignores canVerbosePrint when calling verbosePrint method within block so that it always prints
>>*   **withoutVerbosePrint**: Ignores canVerbosePrint when calling verbosePrint method within block so that it never prints
>>*   **withDebugPrint**: Ignores canDebugPrint when calling debugPrint method within block so that it always prints
>>*   **withoutDebugPrint**: Ignores canDebugPrint when calling debugPrint method within block so that it never prints
>>*   **withAnyPrint**: Ignores any can..Print indicators when calling any print method within block so that they always print
>>*   **withAnyPrint**: Ignores any can..Print indicators when calling any print method within block so that they never print


## Requirements

* Xcode 9+ (If working within Xcode)
* Swift 4.0+

## Usage

```swift
import UnitTestingHelper

class TargetTests: XCExtenedTestCase {
    override class func setUp() {
        super.setUp()
        initTestingFile() //This must be called otherwise path properties will not work
    }

    func test() {
        let workingFile = self.testTargetURL.appendPathComponent("testfile.ext")
        do {
            let workingData = try Data(contentsOf: workingFile)
            // Process file here
            ...
        } catch {
            ...
        }
    }
    ...
}
```

## Author

* **Tyler Anger** - *Initial work*  - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

*Copyright 2020 Tyler Anger*

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[HERE](LICENSE.md) or [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
